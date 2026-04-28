Return-Path: <netdev+bounces-281887-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJvaEOrB8GloYQEAu9opvQ
	(envelope-from <netdev+bounces-281887-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:19:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD45B486CB8
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 424E23067C7D
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB4C44D696;
	Tue, 28 Apr 2026 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csFU2Z6q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3683A44D030
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383420; cv=none; b=OsT/dKiSrz2Q8YsLxzNjY5Uyyo5EcQTCJMj84z2LisX/id9GoLI4smLLawbxFovGLxTW+NKCjJzBVEDb9SBnnSWoM2W6VmL8k1dK1XvAcAyT+OnanKG7cXTuzNSuEBp7ZYgJHCLHfytr6yBUrKNSk3+ibQcnNlJl+c1uEln+gvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383420; c=relaxed/simple;
	bh=omKdTqW56cQNgMCJYhjGQoBYjcJDylgCWQlF/x9N2vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QqvoVsRI5r80lhu3ZDWkRqDJCwllrL6B7SMbGdHqxMzXxwfyTHZ3JGi5mkwRFiw106Gx1mVWj9/8IbQx5opoZgl7vNPscfpcgvTBwBZP0a3rZ0n/7EH9a6cc0HfZFPgnQkfVRvgsuZUR86b4soJXbDAhjJXsV27HwImD8xaSVw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csFU2Z6q; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso58204445e9.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 06:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777383418; x=1777988218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GaLbgtCyLwXTc2vjiwqYx7+YT/HZgQXbQZLJbUSF57E=;
        b=csFU2Z6qErP0/paUJ7Hl7tDR6JuhOJqW0pA8OCcLHOH2OT6ItnznkCZ66P4fCPmf/M
         kPyNXSO6yTEohjTVgFJFylAySVTZTMoctH/KhPqjND3K7yC9aY2ZSDMuewiXpHeGiskr
         CvWwWB8n1ttbE8Oc3L+mj7ylfyX6G4fqIDmDk803XuK40SlFDkq4HvGV4V2P6Ht1ZGF/
         HliMf6BWdwCeToH9wBoFau5dfLbgJwhWSb9WR+HGg0/hM3ASWHbkug1lTmf33ZCLlB5D
         8NXQwpedPORrv1rUl0UrI+g7Xom7Z9RXQRshuc4/8AbMwiG/Oh5Lvdpd6hzbmJtzFm5e
         YdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777383418; x=1777988218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GaLbgtCyLwXTc2vjiwqYx7+YT/HZgQXbQZLJbUSF57E=;
        b=VCsZW51zWaNqnED75o7M41EPsokirs9k8hMM+J6ae++SfeWtgVO4ABU5yDPh+u/wo+
         ZfpqFcjExeRXIvnVvkGJC7s08AYcloh59/LuvVNDub1864vTz12fCFsmrgcPDHndqs0j
         Vw+K3bjmqrfazUtFGoaUv1nabibr53/AhB120DuKPshS9LxlNmtXP2sF+/9xqF3Lsbda
         KxQWmssCmJ9907cePj+OFIzbguI59iCDqquurnaGmO+Lv2bFCVb8fxAR/ICjGFXxBoI9
         s09X6ZavCbIfxEj5blTpx3uWw38v/bZ5oIYM2lEGdvttvlkVpke8js2PlE4b3FiWSAwt
         4tSQ==
X-Forwarded-Encrypted: i=1; AFNElJ+C4iV9c3UOBKmbOXD7BQZA5yZ0pXvtde5Bb10YpuVzlDOH5L9I84pQhmc2MX+1rJY/Z/4rZYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YytK4T4Z6KmXi5XQQyYXQPoiK5atSXgG3Lsao6Jce7ED7TAdOrp
	RyiQHREZRmKSXITflPhGPvIFx2jdod0VP9hG4SCsrLPnjNcbk4MUs9Me
X-Gm-Gg: AeBDiesluP4zF8A+Od5RvKmF5NzDgW4FGLSONlrtq+/VVlUO75lN6e1Emtheymrx6Jf
	BXnaVa7Xdi0K+QMicNBCCgb0c9TEVA+rtoRGbjAhEgPPlhiOPHnyoEgMlJjbwX4Hp7djqPZkbMC
	ViWFNdJuI9sXX0KU81QCzFY/0o1dqOOp3whWQl/D1Uy4TO3LvfYyqoJZ/0t3jfEQRlNBsKCeNj5
	OABRHWCbDA2YAvez5izgw8X41YGm8dnzxC05IKB/xj3LexpJd3GAM4KsaK/7bx1CMuKnftM2ABD
	JPpo9GmK4p/ScBzuFYPFzgmg6HS/WwJk/nwDf7wScgbBvji9HFvsQAKf+eUC1TG4DBkTe23l2W1
	uK3YE/gUAETC6EHsD2Xbki+Jyd0sCRxSxiirsxk0SddDiHqvIVhnmeUieJ1uSFY7su6y5NxNPHZ
	SpNMIpkxa8+iVi9AqvhPDl/SmxvMQXO7b023LBNCVunbnKRfSEcxms0cZNvev37WeuxYAHcS7nt
	ZoCPsISB2oVl+Po1rp7CCD2
X-Received: by 2002:a05:600c:8b4c:b0:48a:65ad:1881 with SMTP id 5b1f17b1804b1-48a77af28f1mr52177695e9.13.1777383417437;
        Tue, 28 Apr 2026 06:36:57 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463ff5a1acsm6284374f8f.33.2026.04.28.06.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 06:36:56 -0700 (PDT)
Message-ID: <0dd0c884-c846-4f17-986d-fb24b21a836f@gmail.com>
Date: Tue, 28 Apr 2026 14:36:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] sfc: fix error code in
 efx_devlink_info_running_versions()
To: Dan Carpenter <error27@gmail.com>,
 Alejandro Lucero <alejandro.lucero-palau@amd.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Martin Habets <habetsm.xilinx@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <aeyEzO6C-v6J1VHH@stanley.mountain>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <aeyEzO6C-v6J1VHH@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AD45B486CB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281887-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,vger.kernel.org,amd.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ecreexilinx@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 25/04/2026 10:09, Dan Carpenter wrote:
> Return -EINVAL if efx_mcdi_rpc() doesn't return enough space.
> 
> Fixes: 14743ddd2495 ("sfc: add devlink info support for ef100")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
>  drivers/net/ethernet/sfc/efx_devlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_devlink.c b/drivers/net/ethernet/sfc/efx_devlink.c
> index d842c60dfc10..45f412bb9b5d 100644
> --- a/drivers/net/ethernet/sfc/efx_devlink.c
> +++ b/drivers/net/ethernet/sfc/efx_devlink.c
> @@ -531,7 +531,7 @@ static int efx_devlink_info_running_versions(struct efx_nic *efx,
>  	if (rc || outlength < MC_CMD_GET_VERSION_OUT_LEN) {
>  		netif_err(efx, drv, efx->net_dev,
>  			  "mcdi MC_CMD_GET_VERSION failed\n");
> -		return rc;
> +		return rc ?: -EINVAL;
>  	}
>  
>  	/* Handle previous output */

Usual practice in sfc is to use -EIO for 'MC response was too short'; it
 signifies misbehaviour from the hardware, not any invalid input argument
 as -EINVAL would suggest.
Other than that, looks fine.

-ed

