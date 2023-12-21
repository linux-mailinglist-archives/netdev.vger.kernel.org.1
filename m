Return-Path: <netdev+bounces-59446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 510D481ADD9
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 05:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE3D1C229F6
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 04:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73858525F;
	Thu, 21 Dec 2023 04:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Kt7hsQB/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3DF63A1
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 04:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d3e6c86868so3309515ad.1
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 20:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1703131438; x=1703736238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xa7YSugVZYhoKKI7omvmi0pgRuDGtWLCnQwy55SJhYA=;
        b=Kt7hsQB/uKhfHKECvEZULhHFgcL1zQIJzLJt3pc6ERu0yrvJzcpFOgF6P3cGEUkate
         CYvl7LJyFOfq4eAQzbUvYxuE1smGAAVLidFr+b6uPFmUzaAQyMYpRm6j4fUJom8U7yhF
         T1j83Ed/lJkPTRAdgXg0Wofwrpv6JPaOUEj76yQ1vym/GHcf9ZtuewpMPB5iwKozX6HO
         o4rdNbG36AUTMWFytCnIPj/g5lBy9nAq47E0OaqBYhjtvcv/CHl66MHe/2dlrr8/YYEv
         QX4EwdNFgMyvNWr2h5m/u7XgEEUSwgdYJsib1sP9Oy8Drqcy8OOs+LKfTZ8zriGA0lyD
         A8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703131438; x=1703736238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xa7YSugVZYhoKKI7omvmi0pgRuDGtWLCnQwy55SJhYA=;
        b=De/zZa0S6794iSAXN2MJFCOjDMYBChBop1PzcUN0LBMEEfu8ZUXq80Dc+sVS9BGcQa
         1K3WK+lnwmbt6+u+eX2RViimjpys+hV9nc1fA402I8Smud12i/lEbOPkVQf2RJxVXgXf
         YqOV7Yhp3eWpCGgeKS2btiG5jO1MxKN6Ot42f3nQStXyFEkuHd2JN/VvHBT94Ra9K24G
         ptGKglWGynnegEusWNY9HkxN+kbFr8Cn1at3wUgTKpbUobwSg+gMMBHfokQsyr6Yayrv
         tfZGxfYkZPRCzOoERKd1C619oTPcnO/K2rBXr84zD1kH9H6jkoJ0ByyDg6YP+9JPzZ+5
         KO+g==
X-Gm-Message-State: AOJu0Ywy1KoPgncyYEp4Yh+MJSUlcC0LKw07HgcSO60F/qVngKqj9soq
	qirxpitR7Dm/EIuAaf1cK5I+Uw==
X-Google-Smtp-Source: AGHT+IGCD2mtnLyu7lByjbN98yTR5EIJyxct0qZCL9SbE+2UvbHhU+c0wroWs6dgDK+6XleksTL+zg==
X-Received: by 2002:a17:903:1103:b0:1d3:5111:e783 with SMTP id n3-20020a170903110300b001d35111e783mr15377127plh.139.1703131438143;
        Wed, 20 Dec 2023 20:03:58 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id ix18-20020a170902f81200b001d09be1bcf9sm517893plb.80.2023.12.20.20.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 20:03:57 -0800 (PST)
Date: Wed, 20 Dec 2023 20:03:54 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, Petr Machata <petrm@nvidia.com>, Roopa Prabhu
 <roopa@nvidia.com>
Subject: Re: [PATCH iproute2-next 06/20] bridge: vlan: Use printf() to avoid
 temporary buffer
Message-ID: <20231220200354.1b7023e1@hermes.local>
In-Reply-To: <20231211140732.11475-7-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
	<20231211140732.11475-7-bpoirier@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 09:07:18 -0500
Benjamin Poirier <bpoirier@nvidia.com> wrote:

> Currently, print_vlan_tunnel_info() is first outputting a formatted string
> to a temporary buffer in order to use print_string() which can handle json
> or normal text mode. Since this specific string is only output in normal
> text mode, by calling printf() directly, we can avoid the need to first
> output to a temporary string buffer.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Tested-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
> ---
>  bridge/vlan.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/bridge/vlan.c b/bridge/vlan.c
> index dfc62f83..797b7802 100644
> --- a/bridge/vlan.c
> +++ b/bridge/vlan.c
> @@ -662,11 +662,8 @@ static void print_vlan_tunnel_info(struct rtattr *tb, int ifindex)
>  		open_json_object(NULL);
>  		width = print_range("vlan", last_vid_start, tunnel_vid);
>  		if (width <= VLAN_ID_LEN) {
> -			char buf[VLAN_ID_LEN + 1];
> -
> -			snprintf(buf, sizeof(buf), "%-*s",
> -				 VLAN_ID_LEN - width, "");
> -			print_string(PRINT_FP, NULL, "%s  ", buf);
> +			if (!is_json_context())
> +				printf("%-*s  ", VLAN_ID_LEN - width, "");
>  		} else {

I think the fix needs to be deeper here.
In JSON the width doesn't matter.

