Return-Path: <netdev+bounces-227330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 133E5BACA6F
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 13:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28EDB7A1498
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 11:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F5924467A;
	Tue, 30 Sep 2025 11:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRHsesoG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAF21F1932
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759230836; cv=none; b=DOW6XwlUtPuYZOJ9b7jgIAMeI8nZwXkOc4OXfqaS+ZzuKWyFyPatOCHAJ/q7UuCNQlnn/r6DrsT4TehEfd+9upO38L9rvy+BPDp0vjl5+Rsc/hAKaAoQep3lcA5Fe6dZ33XZjcF9BZXq/I+O9LG5rvhkRHkMiduGOTYIsUSLh38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759230836; c=relaxed/simple;
	bh=k93mxj134tykzcVQj1QfAGA+nyICxzHFdI2oEVReNtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hINSt3ow0G1PzP5FQRrd49i7Uco91tYRSIG4SFuxuBfx4FT+1jk8fACGhIsHGeVw0qxunMrH9ljSwZgzmPO7eZ5XwRgVuYYsV/1Xki5oJ1sm6qt1yOP6msxOrKaaBq66evbHXXN+p4gyE2GhcAWHHB4egFzur0dOB/w4l26Zsuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BRHsesoG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759230833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9KcvC5cBSi1iBleTgpoe3AI8RltwCt0Ed3z8BuW4Pu8=;
	b=BRHsesoGPQ7eLAeebf25GR/FEafwNgeFG/j79+pcmD3iIncidIWwoAP18f4Q+A3612dmi+
	4nP5epbLIeHTPPyvuoHoGAXXIxJ30VnImcx5Qhxnt82HilXcBNRaFqKFECYQpxannuwLi0
	CuQqYslPx3ReT4X8VbNAgb39SXSziI4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-j5hFm9vNPGqrYygWwP-qWg-1; Tue, 30 Sep 2025 07:13:52 -0400
X-MC-Unique: j5hFm9vNPGqrYygWwP-qWg-1
X-Mimecast-MFC-AGG-ID: j5hFm9vNPGqrYygWwP-qWg_1759230831
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ecdd80ea44so4158723f8f.1
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 04:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759230831; x=1759835631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9KcvC5cBSi1iBleTgpoe3AI8RltwCt0Ed3z8BuW4Pu8=;
        b=B3iFAW79fOOvbe1OUBECthpPfKdoT9OUWcUAlea+Znn2OIJ0MiR/NZ8HGyffoDuYi1
         w3RljnX3VAvbwYnaRf6G3gG6GgvmsMgUjao6oZYe2oyAs4cKAfA6bpEkYege5E7PDjOf
         CX/dAdr37dvMvfvDsIZRidwq84wsEDYscwR8aFtW2LVYN50wnGXiXTvhOwj7smHrmSax
         ww7Valju1hwQyvjBUetD70Cx3tpdARaLJ5HAL30WgABCCH2mmvkzyOJo7zPvtvMtPq56
         C2l2ZZ6aCWZ0JWN5BfORFnBOUbiBU0pXkPaW99cGl9dwOhHi4ny1oqnEU/xWuKLu2EPj
         JATA==
X-Forwarded-Encrypted: i=1; AJvYcCUcqmg741tQcXdL7/A7o3FcwpVmco5gw4bNU28bkhdgse39Y7eITfmLCtmN8sKEg8BqmzhyCRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YywkVIjElx4btmw19AXajnFAXw3+0DSZUMb7qf/lkL0oTQNkcii
	a8jATd5YC1zdJf6q2b3Jhu/QeslBze+oi1d3MX1KZaZBcRbakEzy5taEXFiiopmjkKEJUlHsAf+
	5l3eGxoKG2UYUBn12dX9oxCaxO2fsSGn8FCdR9XlwGyr8e1Pp5hx7kxw5GA==
X-Gm-Gg: ASbGncvvz9w/1ktssjx+9EiIeAQMaxMBadfvhRv3O4ImNxCUurZN0YloMIOL8QvFhE4
	GQe15Jfb/qXco5nXoS0S5fbaWe8Qqs2pVWYa8i8lKaQKmbcakVRu+OPAo7NHnS4+qqGUI3aaQ3L
	R7KjiTxVyPD2iQwNAXkHfqEFoenaTiG85oylUlJmoIsrTffirQfCgW1W7mb3FzlnJG+au7pRuq/
	BO6sJQGfnDaeSlvr7XPgeTrzRugsVBYtT/ggLksni6e4nTWMZETXKxoHqY+sXGNdmu5mqurNTad
	kFAOV+lWHXGKoyDJ5kinhn5Tri2FRRCVnBUSElnrmGeJb+p4Y6jxa8aQRELax2ItsNVfZotYZ0M
	DjERKi3eyRriddzTQvg==
X-Received: by 2002:a05:6000:4013:b0:3ec:dd27:dfa3 with SMTP id ffacd0b85a97d-42411e9dc0emr3836742f8f.25.1759230831007;
        Tue, 30 Sep 2025 04:13:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsuO8Iq2wP0Oxbja1qwoJoUN0P64DEkSmlfa8kXErE7tflD0SLgBdRttPrLOYzXZyMTCkKMg==
X-Received: by 2002:a05:6000:4013:b0:3ec:dd27:dfa3 with SMTP id ffacd0b85a97d-42411e9dc0emr3836715f8f.25.1759230830565;
        Tue, 30 Sep 2025 04:13:50 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb017sm22223822f8f.3.2025.09.30.04.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 04:13:50 -0700 (PDT)
Message-ID: <052f3394-ce15-4e6c-bfe2-4dfbee25be29@redhat.com>
Date: Tue, 30 Sep 2025 13:13:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: mscc: ocelot: Fix use-after-free caused by
 cyclic delayed work
To: Duoming Zhou <duoming@zju.edu.cn>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, UNGLinuxDriver@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com
References: <20250927144514.8847-1-duoming@zju.edu.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250927144514.8847-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/27/25 4:45 PM, Duoming Zhou wrote:
> diff --git a/drivers/net/ethernet/mscc/ocelot_stats.c b/drivers/net/ethernet/mscc/ocelot_stats.c
> index 545710dadcf5..d8ab789f6bea 100644
> --- a/drivers/net/ethernet/mscc/ocelot_stats.c
> +++ b/drivers/net/ethernet/mscc/ocelot_stats.c
> @@ -1021,6 +1021,6 @@ int ocelot_stats_init(struct ocelot *ocelot)
>  
>  void ocelot_stats_deinit(struct ocelot *ocelot)
>  {
> -	cancel_delayed_work(&ocelot->stats_work);
> +	cancel_delayed_work_sync(&ocelot->stats_work);
>  	destroy_workqueue(ocelot->stats_queue);
>  }

AFAICS the stat_work can unconditionally reschedule itself, you should
use disable_delayed_work_sync() instead.

Cheers,

Paolo


