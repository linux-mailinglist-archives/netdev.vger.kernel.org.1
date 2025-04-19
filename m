Return-Path: <netdev+bounces-184274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECCFA940C2
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 03:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB01B8E392C
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 01:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4DA3398A;
	Sat, 19 Apr 2025 01:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLMa1iG2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2177080E
	for <netdev@vger.kernel.org>; Sat, 19 Apr 2025 01:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745025225; cv=none; b=OJvYdR7+hs1yIPm0B7ACxFcnAMBxXeg3ysLY87rDe3XEEnoSIRRCODeemoVw0Db7dVhY5hr+OOx50KWG7aCz5uIpMIp6HLjFLXPPBmL9amshfdDDb+UYG2TzW+PxmKuk5slq7Cnip9H+WxWMq9x6rVg/7MXx5RSt6phVhnqj4Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745025225; c=relaxed/simple;
	bh=KW1brpm5ntpV2gdRdjTaMTa4x8lemRCZLjMPekDyZFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaV6uICI3bSwlaR//jefXz4g4qQYfiZywfKXqoT6IRQ/YCYhE5lzGZKWwH5cfnQjhKJLzMibcvs+3JaivLT5X5N5T2PtcVlefGmRKnIuRP1r/Ab4FB0WSL2z0/TJpv9cU/or88ul3OHIFaHRhAG45+OuHr4GpVpGTYJQM0QjJqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLMa1iG2; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso2031269b3a.2
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 18:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745025222; x=1745630022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DlpnVmCZv7tgbZP1+N2vLa3YiePL66KoxRFFLaVJEz8=;
        b=VLMa1iG29fodUWsJ/4hl/ttj8Q41bBMxWs2bntBDKBSk94uVyPp3R49V5afOLnjS8O
         TV0QYMt99lDOPSGQ1nf8f1bM69yNGFbxd0lyZAEVBw+h738fTkM7+tzs6aejxY36MIYl
         o86En3fCyXno27P3GirTxdKlSgmHw/YFYer+9rSTnF0O6iVcpqtl0bUxLLgafqp4IA06
         UEVw7wCLl7MwLBOrIZW1OTtxLs69+LGrrYR783qHR2vd7H7k+uM7Yf871fdg7v2TshPC
         yERAasXKJbGoe19+z0xlk77g9YfDADxdlF1dvi7PyLXb/mM0VAzApdTesHmO4tUGrOlM
         B0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745025222; x=1745630022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlpnVmCZv7tgbZP1+N2vLa3YiePL66KoxRFFLaVJEz8=;
        b=Ol2x+/+Ch6kjKtfUPVKU3wZKU3kFitoU4O6y9VoOMIQvKFOA1/6WXbjNGymNKjDS4Q
         dAD1UPEViiJRJa6c0tQHapclyY/O5gh1z8xQgEUuSeiWkNSHQylOd7A9awyAnBvm+dh1
         S+A1ofo6Qa1SoQvKUqbFN+VMKQUMp++D2SNQQtMnREBtVpMvPKfT47M2rVwkv1fz082Y
         XU9+0bVpKT8gOhajrWfhHnz3cOIuMjYFHqF45RMNmNZA0jHCYjz6V6UL84TZjETlFi7A
         VZd/te5r4djVuDgwZKS9F9fYuhZu4yAPPy/ldjeIhSd7cqsKRSJlNn4ecOBYTet+qG7e
         aAyg==
X-Forwarded-Encrypted: i=1; AJvYcCXVMbqLwQWk2/evO98LJF5UTR4HOB/E+wBKOUzQtgO408MjuZ2axB6eMWZUp9/Pv/jhAu/uKLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCe44ZckyV5H+VGFuti6Y39MMH2U1Mp4Cpcw0b13ffmZN6FzPp
	CrdXExOd5m4+WNMwixsM7YkTUotbdpbwDpx4Q+ni34b2xK/T3Q0=
X-Gm-Gg: ASbGnct1+mtnkpja9KKoudcaMVLR7D3gyeOOhvzR6/Sekd8okwBeNwHekCggtjfX3H5
	u4LQZMsJvm0f72NdrlrzicTySkgO7kzH5RnQnlRq3snbEW/+NgONCwOYfF0Cibvu2eiQJVgm0Sv
	wYY4JVt2gVOcYEPKKkL7Fl2bhOowIBJBOceUD2yRix9byQU4rrvuu3mCS8LO5vAb0u+VHNbfwbZ
	FLyUnxUUC9EGiKaikQJOpgwxOZL/3QvbjsfbFHAwTL2ek9a48WjZElR47cNphmJpxkMONXFJKS7
	K+fc6yXoTqGqRKXIfJ2r9vODNNXt+8DzWvEU8yYF
X-Google-Smtp-Source: AGHT+IFEIPhrFk9x/VmD0n+LPePCRZOQdykZY3ericZ3EhvLpqMYWYStnMsbjPyucFt7YWjbZ3pJxw==
X-Received: by 2002:a05:6a21:b8b:b0:1fd:f4df:9a89 with SMTP id adf61e73a8af0-203cbc74c9dmr6326011637.25.1745025221763;
        Fri, 18 Apr 2025 18:13:41 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73dbf90d930sm2243094b3a.81.2025.04.18.18.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 18:13:41 -0700 (PDT)
Date: Fri, 18 Apr 2025 18:13:39 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>, donald.hunter@gmail.com,
	jacob.e.keller@intel.com
Subject: Re: [PATCH net-next] tools: ynl: add missing header deps
Message-ID: <aAL4w0lYkMtR1d5S@mini-arch>
References: <20250418234942.2344036-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250418234942.2344036-1-kuba@kernel.org>

On 04/18, Jakub Kicinski wrote:
> Various new families and my recent work on rtnetlink missed
> adding dependencies on C headers. If the system headers are
> up to date or don't include a given header at all this doesn't
> make a difference. But if the system headers are in place but
> stale - compilation will break.
> 
> Reported-by: Kory Maincent <kory.maincent@bootlin.com>
> Fixes: 29d34a4d785b ("tools: ynl: generate code for rt-addr and add a sample")
> Link: https://lore.kernel.org/20250418190431.69c10431@kmaincent-XPS-13-7390
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: jacob.e.keller@intel.com
> ---
>  tools/net/ynl/Makefile.deps | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
> index 385783489f84..8b7bf673b686 100644
> --- a/tools/net/ynl/Makefile.deps
> +++ b/tools/net/ynl/Makefile.deps
> @@ -20,15 +20,18 @@ CFLAGS_ethtool:=$(call get_hdr_inc,_LINUX_ETHTOOL_H,ethtool.h) \
>  	$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_H_,ethtool_netlink.h) \
>  	$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_GENERATED_H,ethtool_netlink_generated.h)
>  CFLAGS_handshake:=$(call get_hdr_inc,_LINUX_HANDSHAKE_H,handshake.h)
> +CFLAGS_lockd_netlink:=$(call get_hdr_inc,_LINUX_LOCKD_NETLINK_H,lockd_netlink.h)
>  CFLAGS_mptcp_pm:=$(call get_hdr_inc,_LINUX_MPTCP_PM_H,mptcp_pm.h)
>  CFLAGS_net_shaper:=$(call get_hdr_inc,_LINUX_NET_SHAPER_H,net_shaper.h)
>  CFLAGS_netdev:=$(call get_hdr_inc,_LINUX_NETDEV_H,netdev.h)
>  CFLAGS_nl80211:=$(call get_hdr_inc,__LINUX_NL802121_H,nl80211.h)
>  CFLAGS_nlctrl:=$(call get_hdr_inc,__LINUX_GENERIC_NETLINK_H,genetlink.h)
>  CFLAGS_nfsd:=$(call get_hdr_inc,_LINUX_NFSD_NETLINK_H,nfsd_netlink.h)
> +CFLAGS_ovpn:=$(call get_hdr_inc,_LINUX_OVPN,ovpn.h)
>  CFLAGS_ovs_datapath:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
>  CFLAGS_ovs_flow:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
>  CFLAGS_ovs_vport:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
> -CFLAGS_rt-addr:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h)
> +CFLAGS_rt-addr:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
> +	$(call get_hdr_inc,__LINUX_IF_ADDR_H,if_addr.h)
>  CFLAGS_rt-route:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h)
>  CFLAGS_tcp_metrics:=$(call get_hdr_inc,_LINUX_TCP_METRICS_H,tcp_metrics.h)

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

(mostly checked that XXX_H defines listed here match the ones in the
header files)

