Return-Path: <netdev+bounces-258847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLnVJ8fmkmlSzwEAu9opvQ
	(envelope-from <netdev+bounces-258847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 10:43:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D3E14207B
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 10:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8AE1630022EF
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 09:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEEE2E541F;
	Mon, 16 Feb 2026 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+LjmAc6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDCE267B89
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771235011; cv=none; b=dAmdQipJhQFwMb5zjIfb/dSzFROrrJFlm9o2ow+Icv7oEABQfnm4aUTTfuRInbWXBBUxMX4hEAbCLC7xkRZjWgAnzB0EEUocwtAZe6aX4xbrN5aJjBgRe6rqc/RhA+I5rboYyWJ+L1ienXs+++mZA/9sRpKWXSrV2BQhDMfxgrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771235011; c=relaxed/simple;
	bh=Z973ykrQZ4TuhrmDtyToSNOz6AN5KfrHo9ArYpm2osk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K2HeZ5OoCWpy9sf2JVveR1jn8Kx0wZatoFwDEDGJVfi9Sz5yr079gCdVT1pDhMfaPhasF2V+IAxH+sanhaVLwPB6KU8MgcA+JyIYlSPQmkEgOSH5Kjx6aSTfUBA4G+5aEIIJI0IpGd0Hl2vIzHLEr4YxWYmiafiWQC58WLMxaPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+LjmAc6; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8230c839409so2622152b3a.3
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 01:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771235010; x=1771839810; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=opFxkpTldrnxn9AG8jl+J5ZXpQfa5In3y5MA4J00UQM=;
        b=S+LjmAc6gvd4U36z6b0UK50ZvzZErWQOh28H2BMCUmBdmEXWWjmianFT+PiiAo7rPQ
         cfc+GekFCD+waRY2Ajnstmm9LxAFh4MdqaIuEHXrjQ+f3Y5AM0K/7XgUgFtvFyPTfdhk
         f7VbpxMgjoQFIu9ZHamaDxQzV0TJpTsA/s1csSYDTjHgVm6hzH2Wxkze+N7NAfFLUTOR
         ysyc2a8LSkvdPc9gKocjilSO0Esykhn2RB92TbjPAECRpgyvbBCFWDM0Kx/g6NQhWjuH
         beQHqVqsSmzGUaOP+pvcTRXGnM2HxWhKoBwipo1EWtSzDSO2ELtLStDmcOVLsvN8JpmC
         gx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771235010; x=1771839810;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=opFxkpTldrnxn9AG8jl+J5ZXpQfa5In3y5MA4J00UQM=;
        b=h/4wEw32eIKI9zSQdGTbfXRdaX6Wdydc5d7gDRz5NzE5p0+ne85CvY4bw2BmwFYwOs
         dn4NP6UQr93Oih+LM85U8GZD9YdO0EjzBLvV5ibaoBnsYYvW6/9KbUu5QUKBaFp+7OmV
         79HPmQ6iKPPD4Wy71BbOKxupEk4ZAmMC1Qa0c9Dj3/+jKKAN9kS4Wxm0Gq1cbfL5xQhW
         jAz5YbDVNfGNc+z6VTfKRR28QDEYhGRtwNwpu1o1cyk0JKAfy7Jmwjg3eRhwv3DbjZ4t
         Dyilxr1HtaMcbBm16zXd1vsaelHH2VReU5OwJTHQNnEDwu4LdEnYeta2AtyoM1zOhOG0
         nUhg==
X-Gm-Message-State: AOJu0YxdlcV+iR71niutokroFIP9ODfp9725QbVTPaaceu4MY0vNFvdn
	HKuf2yW71lAWS3lioNHnXBHDgfVksCz3YAmJpB9dBGpCo1YAf1Jhzc1R
X-Gm-Gg: AZuq6aKavQ+uLzckr9u+Urvca15ILLD32qH3O9yt3qKrN+h5LRtmLskRBaVRIu66JPK
	5hwkfTF3+D2IgS/wJ0v/UsTaZLZmO3nmZWmqRebUx2AOHeaUc4M9zReDsc8aOIqNpUtc5Rv5JqJ
	S6kYBDG47WgZP0q3Xpi8ke2mHLCbVPQd4ylXsxGk4xDO+gHxiprrQBVQfyl7wzW+68Pgoqh3VyR
	WUulCIKXoePGBDy6GtBUik3ZXeTJM7miyOJA8sQOcwLh+q15S/0aZS6OHDYFpB+CJPYImk+CkaQ
	jLpmIY2PqxTlRxP1NLcBwCqXGYDQGBsTgxr1L1Ta2Cq5gsHQ+oWL10TWD13KH54keEInDsOJl4T
	EdLH9bLLi170WuDlvcnSLlWEYnxyFK8etZl1VXrOjjmNvRT/5gjQpb4BMXfDUZkXs6rr4zjna9i
	PypESypL9fYapLJPJrejn3fGBFPxqW6JaezMOLgcuwQw==
X-Received: by 2002:a05:6a00:3996:b0:81f:4675:c2a9 with SMTP id d2e1a72fcca58-824c9310c16mr8796350b3a.0.1771235010183;
        Mon, 16 Feb 2026 01:43:30 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b94009sm10100604b3a.52.2026.02.16.01.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 01:43:29 -0800 (PST)
Date: Mon, 16 Feb 2026 18:43:26 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH] espintcp: Use disable_work_sync() instead of
 cancel_work_sync() in espintcp_close()
Message-ID: <aZLmvv51f5Iu9G7b@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258847-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 47D3E14207B
X-Rspamd-Action: no action

After cancel_work_sync() is called from espintcp_close(), 
espintcp_tx_work() can still be scheduled from paths such as 
the Delayed ACK handler or ksoftirqd.
As a result, the espintcp_tx_work() worker may dereference a 
freed espintcp ctx or sk.

To prevent this race condition, cancel_work_sync() is 
replaced with disable_work_sync().

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/xfrm/espintcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index bf744ac9d5a7..8709df716e98 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -536,7 +536,7 @@ static void espintcp_close(struct sock *sk, long timeout)
 	sk->sk_prot = &tcp_prot;
 	barrier();
 
-	cancel_work_sync(&ctx->work);
+	disable_work_sync(&ctx->work);
 	strp_done(&ctx->strp);
 
 	skb_queue_purge(&ctx->out_queue);
-- 
2.43.0


