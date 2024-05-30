Return-Path: <netdev+bounces-99388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BE98D4B37
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 14:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9C291C2319C
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 12:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB781822F9;
	Thu, 30 May 2024 12:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV7VyKYW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0377417994D;
	Thu, 30 May 2024 12:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070475; cv=none; b=EEqv8bPvZ1J232aDmu2EkDfF65e5tgCDerpeAsm2hhzxje91fsVirdB6+VJGLY3sDnM8TQQG+jFLNdywG1/RX0sFfeb4hI8meUvKslzsJxOqAnC+Bpah+r73KetOYVkSsb1QP9X5TekpXsv8nqb+2KXvD6BqVkAVQYORk0aDA3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070475; c=relaxed/simple;
	bh=Tl6DTRhvTbHYhZAg1L7YnyT3uFvW0YlIVmWcMHuwnK8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=RbqJf9YbXjCUHLMr3Z5gBgh9VkiSjeDbTAPtVSpDzZ6cGRV7xzz2SK0yrv1IEi3ASqcbFGmHcus0IV3yNx2hIjx57wyIhyv5wyFIoGLMUqmTKgtOcIGMq4a26iVXeLjWAd6wmuuuP7P/jL2eT9eKouOERtPobmIWMV45hW3XgGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QV7VyKYW; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-351da5838fcso817134f8f.1;
        Thu, 30 May 2024 05:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717070472; x=1717675272; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yhumDgLqGsw+W+rll4K5ZUwAewDs5YChN4XpuaaZQ+g=;
        b=QV7VyKYW5Yy/EtPVdR0M3zvfVT6Ym3/GTdX4YuC/t5fwaWi8rgHttJuTJjBHn3ipFJ
         YlrGa2/XlZ9j49tAMms4AiBpcOxkC/FAKylRrYpM6HLvj5IipzpMgwpb6qEPvR5gwZvD
         oGmpuvgCOiCjR2XNGjkstuWF1jv4n5NvnQ5I5A2zD1FzaxHJz3b0qfsZRjM+2SrovWb6
         MUDuFZj8C/onJLx5r0/B1m9/7i8bpPQP/Sdl3P83ggD8d3gGx9TkbA/+wnopKFqxPZvr
         Pmrt2KRuZvjP5rmkuJqUGtsaSgZYz9upvRc0wRE5Oi0axfbvyEIxqPovAHRCZKxmFGE2
         /1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717070472; x=1717675272;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhumDgLqGsw+W+rll4K5ZUwAewDs5YChN4XpuaaZQ+g=;
        b=vlV2BiXDFKFf7sa3ritJWXN2Rt3wRS4E3evSk+3HgQBGONDr295eMgSQuwUijAXhj4
         sD4wBiCpmzoz5I0KkiBoyPvnyeQU0az0G2ShnB+he8epfPUO3wWEKa/M4Ld51ZiUTCw8
         E7qJnOnc8cQmion7Nr3upRZ715KMi7ssvMoBAP7IFEDYahFzpPCAtbMY/o3Jc/hCBqWy
         ZH47P6R3nYDghbWpL9n+v4Mf42pFJT4ABMtqvDKydgkloOkmztdqfrsfu4jPEhK5pJJx
         /SkYi+YZ+u8zkHjW6FZ/sRyCZA3ybq7hNGhOrG7pvhC+zxfNjjRy3ZAEaMMYl7xXCXl1
         Y5rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUNR6x1EqIwnCvRpUsBq+20/AsuRC1St/7Nj7mA6dGEhmdUAPMf5ygnSITU56pda5Ir0xwtp1af8Kde5kU9MrDlfNWIFxovnUKuOhGR6+spNkRYh9ClR7XvG01QRO2kA/Cq3oQ
X-Gm-Message-State: AOJu0Yxv8NMKBglFMsCwiS8FbHga488ohmbhllkUDkm9o9MG8CvSO1S2
	PTjoQRwJVRctryp1EmrRdBj/E7GH6ybUdASUBQ3tysWt9KSJ8TAg
X-Google-Smtp-Source: AGHT+IEfzNTCRkV9qhhoxKRPdHhIipmn0ah+KKGjTsG1lPZAMV631k3LZGQ5R97iAHucUzP0z+5Pow==
X-Received: by 2002:a5d:6e48:0:b0:355:38e:c391 with SMTP id ffacd0b85a97d-35dc00be810mr1234897f8f.51.1717070471978;
        Thu, 30 May 2024 05:01:11 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:c8da:756f:fe9d:41b5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a1c9363sm17283293f8f.72.2024.05.30.05.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 05:01:11 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Oleksij Rempel <o.rempel@pengutronix.de>,  Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,  Dent Project <dentproject@linuxfoundation.org>,
  kernel@pengutronix.de
Subject: Re: [PATCH 2/8] net: ethtool: pse-pd: Expand C33 PSE status with
 class, power and status message
In-Reply-To: <20240529-feature_poe_power_cap-v1-2-0c4b1d5953b8@bootlin.com>
	(Kory Maincent's message of "Wed, 29 May 2024 16:09:29 +0200")
Date: Thu, 30 May 2024 11:32:23 +0100
Message-ID: <m2jzjbd1zc.fsf@gmail.com>
References: <20240529-feature_poe_power_cap-v1-0-0c4b1d5953b8@bootlin.com>
	<20240529-feature_poe_power_cap-v1-2-0c4b1d5953b8@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kory Maincent <kory.maincent@bootlin.com> writes:

> From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
>
> This update expands the status information provided by ethtool for PSE c33.
> It includes details such as the detected class, current power delivered,
> and a detailed status message.
>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  include/linux/pse-pd/pse.h           |  8 ++++++++
>  include/uapi/linux/ethtool_netlink.h |  3 +++
>  net/ethtool/pse-pd.c                 | 22 ++++++++++++++++++++++
>  3 files changed, 33 insertions(+)
>
> diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
> index 6eec24ffa866..04219ca20d60 100644
> --- a/include/linux/pse-pd/pse.h
> +++ b/include/linux/pse-pd/pse.h
> @@ -36,12 +36,20 @@ struct pse_control_config {
>   *	functions. IEEE 802.3-2022 30.9.1.1.2 aPSEAdminState
>   * @c33_pw_status: power detection status of the PSE.
>   *	IEEE 802.3-2022 30.9.1.1.5 aPSEPowerDetectionStatus:
> + * @c33_pw_class: detected class of a powered PD
> + *	IEEE 802.3-2022 30.9.1.1.8 aPSEPowerClassification
> + * @c33_actual_pw: power currently delivered by the PSE in mW
> + *	IEEE 802.3-2022 30.9.1.1.23 aPSEActualPower
> + * @c33_pw_status_msg: detailed power detection status of the PSE
>   */
>  struct pse_control_status {
>  	enum ethtool_podl_pse_admin_state podl_admin_state;
>  	enum ethtool_podl_pse_pw_d_status podl_pw_status;
>  	enum ethtool_c33_pse_admin_state c33_admin_state;
>  	enum ethtool_c33_pse_pw_d_status c33_pw_status;
> +	u32 c33_pw_class;
> +	u32 c33_actual_pw;
> +	const char *c33_pw_status_msg;
>  };
>  
>  /**
> diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
> index b49b804b9495..c3f288b737e6 100644
> --- a/include/uapi/linux/ethtool_netlink.h
> +++ b/include/uapi/linux/ethtool_netlink.h
> @@ -915,6 +915,9 @@ enum {
>  	ETHTOOL_A_C33_PSE_ADMIN_STATE,		/* u32 */
>  	ETHTOOL_A_C33_PSE_ADMIN_CONTROL,	/* u32 */
>  	ETHTOOL_A_C33_PSE_PW_D_STATUS,		/* u32 */
> +	ETHTOOL_A_C33_PSE_PW_STATUS_MSG,	/* binary */

It looks like the type is 'string' ?

> +	ETHTOOL_A_C33_PSE_PW_CLASS,		/* u32 */
> +	ETHTOOL_A_C33_PSE_ACTUAL_PW,		/* u32 */
>  
>  	/* add new constants above here */
>  	__ETHTOOL_A_PSE_CNT,
> diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
> index 2c981d443f27..faddc14efbea 100644
> --- a/net/ethtool/pse-pd.c
> +++ b/net/ethtool/pse-pd.c
> @@ -86,6 +86,13 @@ static int pse_reply_size(const struct ethnl_req_info *req_base,
>  		len += nla_total_size(sizeof(u32)); /* _C33_PSE_ADMIN_STATE */
>  	if (st->c33_pw_status > 0)
>  		len += nla_total_size(sizeof(u32)); /* _C33_PSE_PW_D_STATUS */
> +	if (st->c33_pw_class > 0)
> +		len += nla_total_size(sizeof(u32)); /* _C33_PSE_PW_CLASS */
> +	if (st->c33_actual_pw > 0)
> +		len += nla_total_size(sizeof(u32)); /* _C33_PSE_ACTUAL_PW */
> +	if (st->c33_pw_status_msg)
> +		/* _C33_PSE_PW_STATUS_MSG */
> +		len += nla_total_size(strlen(st->c33_pw_status_msg) + 1);
>  
>  	return len;
>  }
> @@ -117,6 +124,21 @@ static int pse_fill_reply(struct sk_buff *skb,
>  			st->c33_pw_status))
>  		return -EMSGSIZE;
>  
> +	if (st->c33_pw_class > 0 &&
> +	    nla_put_u32(skb, ETHTOOL_A_C33_PSE_PW_CLASS,
> +			st->c33_pw_class))
> +		return -EMSGSIZE;
> +
> +	if (st->c33_actual_pw > 0 &&
> +	    nla_put_u32(skb, ETHTOOL_A_C33_PSE_ACTUAL_PW,
> +			st->c33_actual_pw))
> +		return -EMSGSIZE;
> +
> +	if (st->c33_pw_status_msg &&
> +	    nla_put_string(skb, ETHTOOL_A_C33_PSE_PW_STATUS_MSG,
> +			   st->c33_pw_status_msg))
> +		return -EMSGSIZE;
> +
>  	return 0;
>  }

