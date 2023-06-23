Return-Path: <netdev+bounces-13626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DBB73C4A7
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 01:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F5E281E88
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 23:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357A46138;
	Fri, 23 Jun 2023 23:07:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FA7611C
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 23:07:11 +0000 (UTC)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E8210C
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 16:07:10 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-543ae674f37so785121a12.1
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 16:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687561630; x=1690153630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZwjebhS8oSjOepMrPEN3qEWu5LXm96X6EngyxGqz5U=;
        b=HSxQqYcZPyZyotv/USqu+1+c3VOhQaYEACXvG8GsJmY3fFsmhhy05m7xb9JZ0TIwjc
         h0bKF1P9ob29gmZaGk/taEcnoi/rubps701VKrScS8mVMNDjZhGYEeTJEcwn3IZ7JsTu
         2elvlABFLX/7od9P2UOn3vUKIR+DYi+whX4dI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687561630; x=1690153630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZwjebhS8oSjOepMrPEN3qEWu5LXm96X6EngyxGqz5U=;
        b=DbkyvztwrMZQ356Vd3RkGCSsDz8hYyAAzk7+MrAidjSQMJO9ZZM/pIThh923sA7TkY
         oV5gtLjLBS8kCdUROdiqde7ARKE8D16FMWvI9JmqLyaLsCARY8bwPGNsu8ZMCN63K3vX
         qVeNF+7f7b816/9yn0T1Y88qKD0MAU3nkaeaOLEBfGR9xTJHtueoij29NZvi4wfLiT88
         SqC2/LKQcbzrwS85A3zZ2Btq84dQawWqCEXMbLLh2vOQCf4gXbfLXiTyYhd08yCotsIk
         QLKdxcZG4U1UTOXVhXiu53zXZZACQe6RGodK3ABL147xbFSNprU81qSvD5i4hyQjXcTa
         sDxw==
X-Gm-Message-State: AC+VfDz338nERSNeJW7xgEFQEbKyQgCh7ZyGhHcHsNaxoGGNDxMToWds
	XCWlJvx5AyeqNGF7yxcLRbFFjQ==
X-Google-Smtp-Source: ACHHUZ4IKOjqORw3yAofmWeRs2DFniNkRHfGIjXvl8mC28hI/xc2A8BRRpPGb4YGHK+0amfW7QYZzA==
X-Received: by 2002:a17:902:8487:b0:1b6:7031:d22c with SMTP id c7-20020a170902848700b001b67031d22cmr377127plo.38.1687561630059;
        Fri, 23 Jun 2023 16:07:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902988d00b001b680aab2f0sm84020plp.121.2023.06.23.16.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 16:07:09 -0700 (PDT)
Date: Fri, 23 Jun 2023 16:07:08 -0700
From: Kees Cook <keescook@chromium.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Lamparter <chunkeey@googlemail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Ryder Lee <ryder.lee@mediatek.com>, Ilan Peer <ilan.peer@intel.com>,
	Felix Fietkau <nbd@nbd.name>, Aloka Dixit <quic_alokad@quicinc.com>,
	Avraham Stern <avraham.stern@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] mac80211: make ieee80211_tx_info padding explicit
Message-ID: <202306231604.1D327AFE9@keescook>
References: <20230623152443.2296825-1-arnd@kernel.org>
 <20230623152443.2296825-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623152443.2296825-2-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 05:24:00PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> While looking at a bug, I got rather confused by the layout of the
> 'status' field in ieee80211_tx_info. Apparently, the intention is that
> status_driver_data[] is used for driver specific data, and fills up the
> size of the union to 40 bytes, just like the other ones.
> 
> This is indeed what actually happens, but only because of the
> combination of two mistakes:
> 
>  - "void *status_driver_data[18 / sizeof(void *)];" is intended
>    to be 18 bytes long but is actually two bytes shorter because of
>    rounding-down in the division, to a multiple of the pointer
>    size (4 bytes or 8 bytes).
> 
>  - The other fields combined are intended to be 22 bytes long, but
>    are actually 24 bytes because of padding in front of the
>    unaligned tx_time member, and in front of the pointer array.
> 
> The two mistakes cancel out. so the size ends up fine, but it seems
> more helpful to make this explicit, by having a multiple of 8 bytes
> in the size calculation and explicitly describing the padding.
> 
> Fixes: ea5907db2a9cc ("mac80211: fix struct ieee80211_tx_info size")
> Fixes: 02219b3abca59 ("mac80211: add WMM admission control support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/net/mac80211.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index 3a8a2d2c58c38..ca4dc8a14f1bb 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -1192,9 +1192,11 @@ struct ieee80211_tx_info {
>  			u8 ampdu_ack_len;
>  			u8 ampdu_len;
>  			u8 antenna;
> +			u8 pad;
>  			u16 tx_time;
>  			u8 flags;
> -			void *status_driver_data[18 / sizeof(void *)];
> +			u8 pad2;
> +			void *status_driver_data[16 / sizeof(void *)];
>  		} status;

pahole agrees with your assessment. :)

struct ieee80211_tx_info {
	...
        union {
		...
                struct {
                        struct ieee80211_tx_rate rates[4]; /*     8    12 */
                        s32        ack_signal;           /*    20     4 */
                        u8         ampdu_ack_len;        /*    24     1 */
                        u8         ampdu_len;            /*    25     1 */
                        u8         antenna;              /*    26     1 */

                        /* XXX 1 byte hole, try to pack */

                        u16        tx_time;              /*    28     2 */
                        u8         flags;                /*    30     1 */

                        /* XXX 1 byte hole, try to pack */

                        void *     status_driver_data[2]; /*    32    16 */
                } status;                                /*     8    40 */
                struct {
                        struct ieee80211_tx_rate driver_rates[4]; /*     8    12 */
                        u8         pad[4];               /*    20     4 */
                        void *     rate_driver_data[3];  /*    24    24 */
                };                                       /*     8    40 */
                void *             driver_data[5];       /*     8    40 */
        };                                               /*     8    40 */
	...
};

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

