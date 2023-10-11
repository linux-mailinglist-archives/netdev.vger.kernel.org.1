Return-Path: <netdev+bounces-39804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD017C4837
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 05:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35579281D9B
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 03:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582836124;
	Wed, 11 Oct 2023 03:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C92A354EB
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 03:14:28 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F6891;
	Tue, 10 Oct 2023 20:14:26 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VtuX8-x_1696994062;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0VtuX8-x_1696994062)
          by smtp.aliyun-inc.com;
          Wed, 11 Oct 2023 11:14:23 +0800
Date: Wed, 11 Oct 2023 11:14:22 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>, David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Stefan Raspl <raspl@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Nils Hoppmann <niho@linux.ibm.com>,
	Niklas Schnell <schnelle@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>
Subject: Re: [PATCH net] net/smc: Fix pos miscalculation in statistics
Message-ID: <20231011031422.GJ92403@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20231009144048.73130-1-wenjia@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009144048.73130-1-wenjia@linux.ibm.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 04:40:48PM +0200, Wenjia Zhang wrote:
>From: Nils Hoppmann <niho@linux.ibm.com>
>
>SMC_STAT_PAYLOAD_SUB(_smc_stats, _tech, key, _len, _rc) will calculate
>wrong bucket positions for payloads of exactly 4096 bytes and
>(1 << (m + 12)) bytes, with m == SMC_BUF_MAX - 1.
>
>Intended bucket distribution:
>Assume l == size of payload, m == SMC_BUF_MAX - 1.
>
>Bucket 0                : 0 < l <= 2^13
>Bucket n, 1 <= n <= m-1 : 2^(n+12) < l <= 2^(n+13)
>Bucket m                : l > 2^(m+12)
>
>Current solution:
>_pos = fls64((l) >> 13)
>[...]
>_pos = (_pos < m) ? ((l == 1 << (_pos + 12)) ? _pos - 1 : _pos) : m
>
>For l == 4096, _pos == -1, but should be _pos == 0.
>For l == (1 << (m + 12)), _pos == m, but should be _pos == m - 1.
>
>In order to avoid special treatment of these corner cases, the
>calculation is adjusted. The new solution first subtracts the length by
>one, and then calculates the correct bucket by shifting accordingly,
>i.e. _pos = fls64((l - 1) >> 13), l > 0.
>This not only fixes the issues named above, but also makes the whole
>bucket assignment easier to follow.
>
>Same is done for SMC_STAT_RMB_SIZE_SUB(_smc_stats, _tech, k, _len),
>where the calculation of the bucket position is similar to the one
>named above.
>
>Fixes: e0e4b8fa5338 ("net/smc: Add SMC statistics support")
>Suggested-by: Halil Pasic <pasic@linux.ibm.com>
>Signed-off-by: Nils Hoppmann <niho@linux.ibm.com>
>Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>


Good catch, thanks !

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

>---
> net/smc/smc_stats.h | 14 +++++++++-----
> 1 file changed, 9 insertions(+), 5 deletions(-)
>
>diff --git a/net/smc/smc_stats.h b/net/smc/smc_stats.h
>index aa8928975cc6..9d32058db2b5 100644
>--- a/net/smc/smc_stats.h
>+++ b/net/smc/smc_stats.h
>@@ -92,13 +92,14 @@ do { \
> 	typeof(_smc_stats) stats = (_smc_stats); \
> 	typeof(_tech) t = (_tech); \
> 	typeof(_len) l = (_len); \
>-	int _pos = fls64((l) >> 13); \
>+	int _pos; \
> 	typeof(_rc) r = (_rc); \
> 	int m = SMC_BUF_MAX - 1; \
> 	this_cpu_inc((*stats).smc[t].key ## _cnt); \
>-	if (r <= 0) \
>+	if (r <= 0 || l <= 0) \
> 		break; \
>-	_pos = (_pos < m) ? ((l == 1 << (_pos + 12)) ? _pos - 1 : _pos) : m; \
>+	_pos = fls64((l - 1) >> 13); \
>+	_pos = (_pos <= m) ? _pos : m; \
> 	this_cpu_inc((*stats).smc[t].key ## _pd.buf[_pos]); \
> 	this_cpu_add((*stats).smc[t].key ## _bytes, r); \
> } \
>@@ -138,9 +139,12 @@ while (0)
> do { \
> 	typeof(_len) _l = (_len); \
> 	typeof(_tech) t = (_tech); \
>-	int _pos = fls((_l) >> 13); \
>+	int _pos; \
> 	int m = SMC_BUF_MAX - 1; \
>-	_pos = (_pos < m) ? ((_l == 1 << (_pos + 12)) ? _pos - 1 : _pos) : m; \
>+	if (_l <= 0) \
>+		break; \
>+	_pos = fls((_l - 1) >> 13); \
>+	_pos = (_pos <= m) ? _pos : m; \
> 	this_cpu_inc((*(_smc_stats)).smc[t].k ## _rmbsize.buf[_pos]); \
> } \
> while (0)
>-- 
>2.40.1

