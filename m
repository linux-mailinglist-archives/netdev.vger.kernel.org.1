Return-Path: <netdev+bounces-65579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9861F83B108
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 19:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5F11C2234F
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 18:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FFE12BE8D;
	Wed, 24 Jan 2024 18:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShB8Tn3g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E6712AAE9;
	Wed, 24 Jan 2024 18:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120642; cv=none; b=UFg9EOrHGLjcDHeJIXNHDdQGADkxjfx0fBI70GigOxaZoGz0cM+7U5MNrqp7zIggLbtzA+gL6+ap/Rj4oMk743QBA//p3AUPcy17/YmH9smMBbLOjHcRC4qiBebhWVaoL+yBd3io9aAx8m+elcUX/PcYe6tucB8484B0MpiOe5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120642; c=relaxed/simple;
	bh=nU6xcTrI6g1Jq2zxNI8SOuEDGkcRX7IDDkoDcXY878A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=swqjR8y4k56QqiRCdRLCabM26dPBAQDr1V9qMbTXrT+6yBalqPCvhXdlQriNTLvponf5XkC0lhe4l3hJrxwnH8QDgYiaazQXqb63UjM+YtpmSxOCzgY3UWMkAqXLq8QW+GiecQ8MLvsqhXy7Sws0JBMcrtkSw8d5m6bbwTfe4uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShB8Tn3g; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42a4516ec5dso17938811cf.3;
        Wed, 24 Jan 2024 10:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706120640; x=1706725440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6A9H4eWFFRcapkOd1pDgCiuF/af9kh86NY13LEMW5E=;
        b=ShB8Tn3g0eCZIDzf6XwpR0EpPkx4DNnB3DeOrrrAx7qjMJX7TcpXamqrsGIzujJuML
         3ZMOlO1UBZnhcyjRqzKZkJlLbeOwfNULAMUPVufAjuzAmOc3aXSn7/avvJG9jFbJh46L
         KhYLTKamBgXRhebPjIv8Kw3wkIKYh1qjoMn58WmyTnV5MUJGbV1EY5jZoVavaB2BLvY3
         9rghQw2/XVFs3psJzkPp8+VaPK9niRCucDe8HmWOTNFhJokFaxL9KIkqeQ+zhNQNnap0
         LFj64W1kUo4VfJS1jNjTh0JId++dtBmWpk54AbMh8LpXE1RTMT3hzNm1x4t94wW4Vq16
         oQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706120640; x=1706725440;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l6A9H4eWFFRcapkOd1pDgCiuF/af9kh86NY13LEMW5E=;
        b=NDY0cKWXGFmjRHqJh+7jSi7NIs15Wj5oeaxlD867bIitr9urJGUqifHkdYk0WdEHBl
         6bXJNuP4HWjdCJ0k69tLf9QdxUo5poboc/b4U2O5dho9xD7ZyX3gvv6SXDVvfSU37uD3
         mR+OC1MblBO64DrETi2rTSLDK53ul5ytRQrKWBi//lpBNzmlV7XqFR8tHyOefGEVRRen
         on3zB1UtwxwUWbHAp/4yBzddteXpb/teTa5LC7R0F6VC/D0b8ghajhOvtRmembbilsvW
         uBAqpQTNRlgtF1MGQ6S1Wj4VF1vqnh+Qf7gExTK5NxiNCkLIJ4cBypjpaxmXxKGy17qT
         tj4g==
X-Gm-Message-State: AOJu0YxgkGO3pQkoRIEwaSFk5+wFJDVXVtD6OBk0fTG+wHpBCTYlwwa1
	lLhT/xFXV2rCcqGCyxYNE/GpaoyHZmoKR4nABsBxCgU4V/nne9Ir
X-Google-Smtp-Source: AGHT+IH+UiO0BSopYTJVGxVTkJLGqF4LThAzNOrlmwqqlTMYphnUrC+dSMqGaHfOGHvorE3Fw23+kA==
X-Received: by 2002:a05:622a:c5:b0:42a:2e9:5e18 with SMTP id p5-20020a05622a00c500b0042a02e95e18mr2622039qtw.101.1706120639836;
        Wed, 24 Jan 2024 10:23:59 -0800 (PST)
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id cm24-20020a05622a251800b004181138e0c0sm4581709qtb.31.2024.01.24.10.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:23:59 -0800 (PST)
Date: Wed, 24 Jan 2024 13:23:59 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, 
 Hangbin Liu <liuhangbin@gmail.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "netdev-driver-reviewers@vger.kernel.org" <netdev-driver-reviewers@vger.kernel.org>, 
 pabeni@redhat.com
Message-ID: <65b155bf549e3_22a8cb294c7@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240124094920.7b63950e@kernel.org>
References: <20240122091612.3f1a3e3d@kernel.org>
 <Za98C_rCH8iO_yaK@Laptop-X1>
 <20240123072010.7be8fb83@kernel.org>
 <d0e28c67-51ad-4da1-a6df-7ebdbd45cd2b@kernel.org>
 <65b133e83f53e_225ba129414@willemb.c.googlers.com.notmuch>
 <20240124082255.7c8f7c55@kernel.org>
 <65b14c16965d7_228db729490@willemb.c.googlers.com.notmuch>
 <20240124094920.7b63950e@kernel.org>
Subject: Re: [ANN] net-next is OPEN
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Wed, 24 Jan 2024 12:42:46 -0500 Willem de Bruijn wrote:
> > > Here's a more handy link filtered down to failures (clicking on 
> > > the test counts links here):
> > > 
> > > https://netdev.bots.linux.dev/contest.html?branch=net-next-2024-01-24--15-00&executor=vmksft-net-mp&pass=0
> > > 
> > > I have been attributing the udpg[rs]o and timestamp tests to you,
> > > but I haven't actually checked.. are they not yours? :)  
> > 
> > I just looked at the result file and assumed 0 meant fine. Oops.
> 
> Sorry about the confusion there, make run_tests apparently always
> returns 0 and the result file holds the exit code :( It could be
> improved by I figured, as long as the JSON output is correct, investing
> the time in the web UI is probably a better choice than massaging 
> the output files.

Absolutely. My bad for jumping to conclusions.

