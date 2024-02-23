Return-Path: <netdev+bounces-74331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1A5860EB8
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 10:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA0B287C35
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 09:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6345CDDC;
	Fri, 23 Feb 2024 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="bWz/DG+V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5835C914
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708682020; cv=none; b=cOMNLqcgkBqt802YGx0ytOBDax8rCtf+QDtGWK8UP8sbdWYGZAhGW9LTY74CO06ABOFHydQxqu4PAGrT+hKgt3d0ZhbaCX/jdIL2uBZjoICF5zpcpvfMsA7WRXld3wUaD8eLTf6Nu/NWHyUjIEY1aSpuDebDjfHxl068JTx3DzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708682020; c=relaxed/simple;
	bh=Bx12cFyEjagEt0KcPcBDUcD/tAwSI8P67qpekMkCTp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxurK1K+5CYYoSQTSQXuAWYHkqB/7v1y/qIC6csNhj5bfAFieyNlIz7cemn7rVq2B9d1g3xbzjaZjwPDJwLvl0TSWA5imG5ovji1sTpSHckvkrWMfjp11LtFpokx5A7uBqVHa5Ebv2lISFm7ZmTljrehjH0efeOFmJJ87sOOfzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=bWz/DG+V; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41295fd7847so1337505e9.1
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 01:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708682017; x=1709286817; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bx12cFyEjagEt0KcPcBDUcD/tAwSI8P67qpekMkCTp8=;
        b=bWz/DG+Vpu84O9QBt1CYPNtWw0WacMljup7UAfOkvN+8bP/loOG20JlPEu+gPtC6+U
         TOJ0ulFox/4DSawH5T83moWFkvJWJIHP7RusVAHrIG0pnzaQ1I5UDtZN4xu/dD7Zi91E
         GS1Dm01jWq5BKrQ/FbTBiw6yDfSa2c5I5pg2xvUY3eyuzi/HtzE61axAZOQ/JjOmkcUd
         rISPll7jfHINGVwTuiPywDi4q8Vm3OhJ14kOHFuqWdBSOScRfseJxo73YAK3xh2OjykW
         Y5YS+j9kmMqo6qXqHy7l4NsrLPqk7eRGSlEeXgO6SG8AW5QgqO6G+0Tgwuoe0tR8q/aj
         8Qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708682017; x=1709286817;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bx12cFyEjagEt0KcPcBDUcD/tAwSI8P67qpekMkCTp8=;
        b=KPRJqc98qCk81Bj0gTl4XO+2KzZAToVay/4j3pzbv1qZR9030u3UsjOy7bugWjdlL8
         qayN3vUQIQmBEmR3auMfqAK0gQSpcFtswv94JKkMNc8Tqz94tcg+2FKwMM1kBJQhGHdi
         osgDpAOzpv90Tae8qROjD1AYpjaMkYZlcGh+dJH2HdSMX5TuMX1Y4Bkpf7MIxVYTDKcq
         o3Wg3DCH6lG0VRyAfCSukCGOo/OpoxHZjfgQubZ6uewJqkp3aake+sByvuCdeGmytArp
         CMvdPNOdjd6NSqzDB+eR8tII+PmIDK4pruhi9A5D2+haSoMmYnzRL/Mm76gUhZmNgv79
         NXXg==
X-Forwarded-Encrypted: i=1; AJvYcCVtFoJVO7QDvGFbKQGqDNkZ41FUPLgTphUUDjtnqD5aWBbDVS4i3zD4Zjjbi3Y2aJXNpmALMqV/LyOHs99hF2t0WA8qbo9g
X-Gm-Message-State: AOJu0YzOWYXCPyglVk2NMEiVQNa9iDVJLXsZvkcSI59enj0J/LyjUaiU
	PaB8wqZmBSI7IOqAYhnDKgajUC2vWC9LqHSzu1I4b9Eu6vKR5kz4XRB3qRmrL+D8QdY+1ec6a46
	9Bm0=
X-Google-Smtp-Source: AGHT+IGKGhz6UXdBsG0HP4qaP8EuQBlgwpS8xyyQVnjL5pp6jRBuRwZjx/C4jI+oTh4Yqm5Brt7oYQ==
X-Received: by 2002:a5d:5347:0:b0:33d:4ee2:883d with SMTP id t7-20020a5d5347000000b0033d4ee2883dmr988305wrv.39.1708682017501;
        Fri, 23 Feb 2024 01:53:37 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id c14-20020adfe74e000000b0033b87c2725csm2103825wrn.104.2024.02.23.01.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 01:53:37 -0800 (PST)
Date: Fri, 23 Feb 2024 10:53:36 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jones Syue =?utf-8?B?6Jab5oe35a6X?= <jonessyue@qnap.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] bonding: 802.3ad replace MAC_ADDRESS_EQUAL with
 __agg_has_partner
Message-ID: <ZdhrIJMB983Hz6nH@nanopsycho>
References: <SI2PR04MB50977DA9BB51D9C8FAF6928ADC562@SI2PR04MB5097.apcprd04.prod.outlook.com>
 <20240222192752.32bb4bf3@kernel.org>
 <SI2PR04MB509756F6E1DB746FA0283407DC552@SI2PR04MB5097.apcprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SI2PR04MB509756F6E1DB746FA0283407DC552@SI2PR04MB5097.apcprd04.prod.outlook.com>

Fri, Feb 23, 2024 at 04:54:11AM CET, jonessyue@qnap.com wrote:
>> You need to CC the maintainers. Please use ./script/get_maintainer.pl
>> to identify the right recipients and resend the patch.
>
>Thank you for kindly feedback! Sure will resend with correct CC :)

While you are sending next v, please re-phrase the patch desctiption
using imperative mood:

https://www.kernel.org/doc/html/v6.6/process/submitting-patches.html#describe-your-changes


>
>--
>
>Regards,
>Jones Syue | 薛懷宗
>QNAP Systems, Inc.
>

