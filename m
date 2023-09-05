Return-Path: <netdev+bounces-32155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66377931D4
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 00:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABFFD1C20A60
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 22:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AEC101D7;
	Tue,  5 Sep 2023 22:15:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC59FFC0F
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 22:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A97CC433CA;
	Tue,  5 Sep 2023 22:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693952110;
	bh=K7DoqPi5LWEMcJo8SKG1rmXcL9ak2qlpFw7Z0l+lF3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T5jnBzgvd+7vurX4i5cqqzDRUyJQboLYrKaawD0ClNWOuMD3gu6HHwwBXLJqG8vez
	 +y1Av3v6SmQmUFuM8SZB02YzZEnGakwmvz5JTzdiYeFCCAwl08lLAZ2B4vypE3tgLu
	 jIck7CHKmeNIT7VYPNlWm0Rci++Y8cT+2y0UwDL3TR8OpP2J/V0hITgFGi2JdRVHBS
	 vyLc2kReEzNEhYC3kiueTh933NcsiAyP+TxZhrqGquh308ptCuGhrjLPx3diruuqnh
	 oGTRTQjwG/TApZKRl4knfH7TD0JFcZw7oy+L8+Hi3SOwhgybpkBK2qu75DqH0Wmbve
	 JMI8+6PfGFZYQ==
Date: Tue, 5 Sep 2023 15:15:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: <piergiorgio.beruto@gmail.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.co>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <horatiu.vultur@microchip.com>,
 <Woojung.Huh@microchip.com>, <Nicolas.Ferre@microchip.com>,
 <Thorsten.Kummermehr@microchip.com>
Subject: Re: [PATCH net-next] ethtool: plca: fix plca enable data type while
 parsing the value
Message-ID: <20230905151509.5208ee63@kernel.org>
In-Reply-To: <20230831104523.7178-1-Parthiban.Veerasooran@microchip.com>
References: <20230831104523.7178-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Aug 2023 16:15:23 +0530 Parthiban Veerasooran wrote:
> Subject: [PATCH net-next] ethtool: plca: fix plca enable data type while parsing the value

Since this is a fix the subject should say net instead of net-next.
[PATCH net v2] for the next revision.

> The ETHTOOL_A_PLCA_ENABLED data type is u8. But while parsing the
> value from the attribute, nla_get_u32() is used in the plca_update_sint()
> function instead of nla_get_u8(). So plca_cfg.enabled variable is updated
> with some garbage value instead of 0 or 1 and always enables plca even
> though plca is disabled through ethtool application. This bug has been
> fixed by implementing plca_update_sint_from_u8() function which uses
> nla_get_u8() function to extract the plca_cfg.enabled value and the
> function plca_update_sint_from_u32() is used for extracting the other
> values using nla_get_u32() function.

Hm, yes, that seems like the best of the available options.

> Fixes: 8580e16c28f3 ("net/ethtool: add netlink interface for the PLCA RS")

Please make sure you CC all the people who signed off the commit under
Fixes. You missed pabeni@redhat.com and andrew@lunn.ch 

> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> ---
>  net/ethtool/plca.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/net/ethtool/plca.c b/net/ethtool/plca.c
> index b238a1afe9ae..b4e80dd33590 100644
> --- a/net/ethtool/plca.c
> +++ b/net/ethtool/plca.c
> @@ -21,8 +21,8 @@ struct plca_reply_data {
>  #define PLCA_REPDATA(__reply_base) \
>  	container_of(__reply_base, struct plca_reply_data, base)
>  
> -static void plca_update_sint(int *dst, const struct nlattr *attr,
> -			     bool *mod)
> +static void plca_update_sint_from_u32(int *dst, const struct nlattr *attr,
> +				      bool *mod)
>  {
>  	if (!attr)
>  		return;
> @@ -31,6 +31,16 @@ static void plca_update_sint(int *dst, const struct nlattr *attr,
>  	*mod = true;
>  }
>  
> +static void plca_update_sint_from_u8(int *dst, const struct nlattr *attr,
> +				     bool *mod)
> +{
> +	if (!attr)
> +		return;
> +
> +	*dst = nla_get_u8(attr);
> +	*mod = true;
> +}
> +
>  // PLCA get configuration message ------------------------------------------- //
>  
>  const struct nla_policy ethnl_plca_get_cfg_policy[] = {
> @@ -144,14 +154,18 @@ ethnl_set_plca(struct ethnl_req_info *req_info, struct genl_info *info)
>  		return -EOPNOTSUPP;
>  
>  	memset(&plca_cfg, 0xff, sizeof(plca_cfg));
> -	plca_update_sint(&plca_cfg.enabled, tb[ETHTOOL_A_PLCA_ENABLED], &mod);
> -	plca_update_sint(&plca_cfg.node_id, tb[ETHTOOL_A_PLCA_NODE_ID], &mod);
> -	plca_update_sint(&plca_cfg.node_cnt, tb[ETHTOOL_A_PLCA_NODE_CNT], &mod);
> -	plca_update_sint(&plca_cfg.to_tmr, tb[ETHTOOL_A_PLCA_TO_TMR], &mod);
> -	plca_update_sint(&plca_cfg.burst_cnt, tb[ETHTOOL_A_PLCA_BURST_CNT],
> -			 &mod);
> -	plca_update_sint(&plca_cfg.burst_tmr, tb[ETHTOOL_A_PLCA_BURST_TMR],
> -			 &mod);
> +	plca_update_sint_from_u8(&plca_cfg.enabled, tb[ETHTOOL_A_PLCA_ENABLED],
> +				 &mod);
> +	plca_update_sint_from_u32(&plca_cfg.node_id, tb[ETHTOOL_A_PLCA_NODE_ID],
> +				  &mod);
> +	plca_update_sint_from_u32(&plca_cfg.node_cnt,
> +				  tb[ETHTOOL_A_PLCA_NODE_CNT], &mod);
> +	plca_update_sint_from_u32(&plca_cfg.to_tmr, tb[ETHTOOL_A_PLCA_TO_TMR],
> +				  &mod);
> +	plca_update_sint_from_u32(&plca_cfg.burst_cnt,
> +				  tb[ETHTOOL_A_PLCA_BURST_CNT], &mod);
> +	plca_update_sint_from_u32(&plca_cfg.burst_tmr,
> +				  tb[ETHTOOL_A_PLCA_BURST_TMR], &mod);

This looks error prone. We still need to maintain the types in multiple
places. How about we use the policy to decide the type? Something along
the lines of (untested):

diff --git a/net/ethtool/plca.c b/net/ethtool/plca.c
index b238a1afe9ae..aed30665e9c0 100644
--- a/net/ethtool/plca.c
+++ b/net/ethtool/plca.c
@@ -21,16 +21,6 @@ struct plca_reply_data {
 #define PLCA_REPDATA(__reply_base) \
 	container_of(__reply_base, struct plca_reply_data, base)
 
-static void plca_update_sint(int *dst, const struct nlattr *attr,
-			     bool *mod)
-{
-	if (!attr)
-		return;
-
-	*dst = nla_get_u32(attr);
-	*mod = true;
-}
-
 // PLCA get configuration message ------------------------------------------- //
 
 const struct nla_policy ethnl_plca_get_cfg_policy[] = {
@@ -125,6 +115,29 @@ const struct nla_policy ethnl_plca_set_cfg_policy[] = {
 	[ETHTOOL_A_PLCA_BURST_TMR]	= NLA_POLICY_MAX(NLA_U32, 255),
 };
 
+static void
+plca_update_sint(int *dst, const struct nlattr **tb, u32 attrid, bool *mod)
+{
+	const struct nlattr *attr = tb[attrid];
+
+	if (!attr ||
+	    WARN_ON_ONCE(attrid >= ARRAY_SIZE(ethnl_plca_set_cfg_policy)))
+		return;
+
+	switch (ethnl_plca_set_cfg_policy[attrid].type) {
+	case NLA_U8:
+		*dst = nla_get_u8(attr);
+		break;
+	case NLA_U32:
+		*dst = nla_get_u32(attr);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+	}
+
+	*mod = true;
+}
+
 static int
 ethnl_set_plca(struct ethnl_req_info *req_info, struct genl_info *info)
 {
@@ -144,13 +157,13 @@ ethnl_set_plca(struct ethnl_req_info *req_info, struct genl_info *info)
 		return -EOPNOTSUPP;
 
 	memset(&plca_cfg, 0xff, sizeof(plca_cfg));
-	plca_update_sint(&plca_cfg.enabled, tb[ETHTOOL_A_PLCA_ENABLED], &mod);
-	plca_update_sint(&plca_cfg.node_id, tb[ETHTOOL_A_PLCA_NODE_ID], &mod);
-	plca_update_sint(&plca_cfg.node_cnt, tb[ETHTOOL_A_PLCA_NODE_CNT], &mod);
-	plca_update_sint(&plca_cfg.to_tmr, tb[ETHTOOL_A_PLCA_TO_TMR], &mod);
-	plca_update_sint(&plca_cfg.burst_cnt, tb[ETHTOOL_A_PLCA_BURST_CNT],
+	plca_update_sint(&plca_cfg.enabled, tb, ETHTOOL_A_PLCA_ENABLED, &mod);
+	plca_update_sint(&plca_cfg.node_id, tb, ETHTOOL_A_PLCA_NODE_ID, &mod);
+	plca_update_sint(&plca_cfg.node_cnt, tb, ETHTOOL_A_PLCA_NODE_CNT, &mod);
+	plca_update_sint(&plca_cfg.to_tmr, tb, ETHTOOL_A_PLCA_TO_TMR, &mod);
+	plca_update_sint(&plca_cfg.burst_cnt, tb, ETHTOOL_A_PLCA_BURST_CNT,
 			 &mod);
-	plca_update_sint(&plca_cfg.burst_tmr, tb[ETHTOOL_A_PLCA_BURST_TMR],
+	plca_update_sint(&plca_cfg.burst_tmr, tb, ETHTOOL_A_PLCA_BURST_TMR,
 			 &mod);
 	if (!mod)
 		return 0;

