Return-Path: <netdev+bounces-167596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DDEA3AFC4
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 03:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66B6172663
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 02:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E434D19007D;
	Wed, 19 Feb 2025 02:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piu/1fcq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A18381AF;
	Wed, 19 Feb 2025 02:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739933115; cv=none; b=RnOo0DS5gOW7CjdJU+kSJAEPTWBEoPkfxZw+ypC1n5TJHX8KXbxQhLZc4uKJesEgd/H7lF2f0WWDAzcoQCCCT/rzh3UzZmNxUFIYUiAj8h2k4VcUjHi7/Ah+auHNT3fuubVuONAv7kS/RBlDAE+gz/yRvVhHhNuJCk4tIXjVcgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739933115; c=relaxed/simple;
	bh=Uj0+jeVodxFXzLFxn3YvbTHPAMSeBiTHDnrVWNUjqm0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGRqMW5PG7X8BLonQeTuUXmAVn4Kz2irsNwp0sIBFLE9QdbECxxZUB6WTjgvzjMNNB3DjeCm0TxNEBI61xOTLPI1bEYKbjmlNcGeLrnVQvhcdQxfzOFtSzZ6Q323Bp1b3Wdyr+HBqOZfjqMoIv9ymkbq2274Cgzv05oonxjv9pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piu/1fcq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2EBC4CEE2;
	Wed, 19 Feb 2025 02:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739933115;
	bh=Uj0+jeVodxFXzLFxn3YvbTHPAMSeBiTHDnrVWNUjqm0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=piu/1fcqCXQAzGTSSqDdQqyxsFRV7n+FzeUNG54N6zBdo48Zg3afT0uU3pL+4v72Q
	 8G+lIPxIe6JO2TgnUrmGOipFONaedsgcxtRuBWe1ZvHHdV2NLIlMXmS/E2cE22Vcpe
	 ZNqNYKKb0yvWcLRnpoFBGCYmaxN41+EO3aMlG/2h+GIF0YGFV3MQEkXLR1X25+AN7f
	 nz/7XF7ysj9aBuzY/EWxf1uY9zbA1jjZBahZgB9w7IuDsNgTNyh44YFCgBjSITG9TH
	 W/v8xJ1qz92p/jdoP7LJ2tz6GBHXkS06Q3XGALpd4go7vcISUbjsPPx3ZT6fjrBhTT
	 x7GpF66YL86PA==
Date: Tue, 18 Feb 2025 18:45:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Tariq Toukan <tariqt@nvidia.com>, Louis Peens
 <louis.peens@corigine.com>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@kernel.org>, "Pravin B Shelar" <pshelar@ovn.org>, Yotam Gigi
 <yotam.gi@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 <dev@openvswitch.org>, <linux-hardening@vger.kernel.org>, Ilya Maximets
 <i.maximets@ovn.org>, Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH net-next v3 1/2] ip_tunnel: Use ip_tunnel_info() helper
 instead of 'info + 1'
Message-ID: <20250218184513.05ac19d0@kernel.org>
In-Reply-To: <20250217202503.265318-2-gal@nvidia.com>
References: <20250217202503.265318-1-gal@nvidia.com>
	<20250217202503.265318-2-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 22:25:02 +0200 Gal Pressman wrote:
> diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
> index af7c99845948..6d97be6bc7fa 100644
> --- a/net/sched/act_tunnel_key.c
> +++ b/net/sched/act_tunnel_key.c
> @@ -572,7 +572,7 @@ static int tunnel_key_geneve_opts_dump(struct sk_buff *skb,
>  				       const struct ip_tunnel_info *info)
>  {
>  	int len = info->options_len;
> -	u8 *src = (u8 *)(info + 1);
> +	u8 *src = (u8 *)ip_tunnel_info_opts(info);
>  	struct nlattr *start;
>  
>  	start = nla_nest_start_noflag(skb, TCA_TUNNEL_KEY_ENC_OPTS_GENEVE);
> @@ -603,7 +603,8 @@ static int tunnel_key_geneve_opts_dump(struct sk_buff *skb,
>  static int tunnel_key_vxlan_opts_dump(struct sk_buff *skb,
>  				      const struct ip_tunnel_info *info)
>  {
> -	struct vxlan_metadata *md = (struct vxlan_metadata *)(info + 1);
> +	struct vxlan_metadata *md =
> +		(struct vxlan_metadata *)ip_tunnel_info_opts(info);
>  	struct nlattr *start;
>  
>  	start = nla_nest_start_noflag(skb, TCA_TUNNEL_KEY_ENC_OPTS_VXLAN);
> @@ -622,7 +623,8 @@ static int tunnel_key_vxlan_opts_dump(struct sk_buff *skb,
>  static int tunnel_key_erspan_opts_dump(struct sk_buff *skb,
>  				       const struct ip_tunnel_info *info)
>  {
> -	struct erspan_metadata *md = (struct erspan_metadata *)(info + 1);
> +	struct erspan_metadata *md =
> +		(struct erspan_metadata *)ip_tunnel_info_opts(info);
>  	struct nlattr *start;

We shouldn't cast the const away any more. 
Squash this in, please:

diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
index 6d97be6bc7fa..ae5dea7c48a8 100644
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -569,20 +569,20 @@ static void tunnel_key_release(struct tc_action *a)
 }
 
 static int tunnel_key_geneve_opts_dump(struct sk_buff *skb,
                                       const struct ip_tunnel_info *info)
 {
+       const u8 *src = ip_tunnel_info_opts(info);
        int len = info->options_len;
-       u8 *src = (u8 *)ip_tunnel_info_opts(info);
        struct nlattr *start;
 
        start = nla_nest_start_noflag(skb, TCA_TUNNEL_KEY_ENC_OPTS_GENEVE);
        if (!start)
                return -EMSGSIZE;
 
        while (len > 0) {
-               struct geneve_opt *opt = (struct geneve_opt *)src;
+               const struct geneve_opt *opt = (const struct geneve_opt *)src;
 
                if (nla_put_be16(skb, TCA_TUNNEL_KEY_ENC_OPT_GENEVE_CLASS,
                                 opt->opt_class) ||
                    nla_put_u8(skb, TCA_TUNNEL_KEY_ENC_OPT_GENEVE_TYPE,
                               opt->type) ||
@@ -601,12 +601,11 @@ static int tunnel_key_geneve_opts_dump(struct sk_buff *skb,
 }
 
 static int tunnel_key_vxlan_opts_dump(struct sk_buff *skb,
                                      const struct ip_tunnel_info *info)
 {
-       struct vxlan_metadata *md =
-               (struct vxlan_metadata *)ip_tunnel_info_opts(info);
+       const struct vxlan_metadata *md = ip_tunnel_info_opts(info);
        struct nlattr *start;
 
        start = nla_nest_start_noflag(skb, TCA_TUNNEL_KEY_ENC_OPTS_VXLAN);
        if (!start)
                return -EMSGSIZE;
@@ -621,12 +620,11 @@ static int tunnel_key_vxlan_opts_dump(struct sk_buff *skb,
 }
 
 static int tunnel_key_erspan_opts_dump(struct sk_buff *skb,
                                       const struct ip_tunnel_info *info)
 {
-       struct erspan_metadata *md =
-               (struct erspan_metadata *)ip_tunnel_info_opts(info);
+       const struct erspan_metadata *md = ip_tunnel_info_opts(info);
        struct nlattr *start;
 
        start = nla_nest_start_noflag(skb, TCA_TUNNEL_KEY_ENC_OPTS_ERSPAN);
        if (!start)
                return -EMSGSIZE;

-- 
pw-bot: cr

