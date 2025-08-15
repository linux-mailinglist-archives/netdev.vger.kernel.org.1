Return-Path: <netdev+bounces-214223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94467B288B6
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 01:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5453BAC2613
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 23:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93412D3725;
	Fri, 15 Aug 2025 23:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="kFzDibt/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334092D0604
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 23:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755300390; cv=none; b=t1ue0xgLAEitPzyROv8VEb2DB6lMBlzMis+gLngc3HygMVJk++QcQylVCq7wSOwQkY3YXeWKWxIC5kc/NETAwjN9I/nxun4/v4TRUHy1805onYFHve82zCJCDVBpvDiU1xxYdJ5c4QULiCfesOxmT1No8xPHwYUIFKSXLaP9HgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755300390; c=relaxed/simple;
	bh=Chu5jY4XwBGOtUKref48cfAFeJ2FGjTr+yJjhVQVaEU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sbSqEmD0IBroAZTKjsEOgRSeh8UkBUzDoWH6upiG3KxTh4PYvvnaoKfqsv1t5souqC/h0KM9kRbkfh88NrS9euRHzN3TJjxpPIl4NjGNLQnKQr1IGATykiORNjGX6v8sH1DCr05U74k04I8IJxQGN693EHAEbSZkWmqwb3r+5bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=kFzDibt/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45a1b0cbbbaso15953635e9.3
        for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 16:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755300387; x=1755905187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XodyE2rBD9AQIrlVLOswdFyZomcRJ3PmmM1np+C7GNM=;
        b=kFzDibt/HLMNUgo6QkVoTdtColdVYNpx/FsWFkFcqJBtyOcHjiKjxEIAU95PdFdOQ7
         JkAiA7Ra+ErTaRxtoRO8DY8wkOx16P7q58ozasvGXof3Di27tNYrfHAjMp3vVPpBcEZt
         8hTB7Uck6YOpoQ0r9pjEwyBN+wLXP0lL5xXXBFfxR4EyQ2NU5uQ5PUVtOBWstAK1dklA
         G3N3AXbTW2BXxNiFX9XXhBSQiWrJNh8mbEP+3MVVUVl+5yQySWzHmUi7DwVlgk11DPqz
         s7/5uU8D2jHgIsD/2cj9lKLfAhqxfd/IzfsGmBKr/VRhf28tjZWuHT1Ldx/rqw5aiCR0
         FP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755300387; x=1755905187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XodyE2rBD9AQIrlVLOswdFyZomcRJ3PmmM1np+C7GNM=;
        b=wAeusjki396kTh/33MKVVSKz8gd6Ro6bZnjjigRF8yssf47qtDP2DceWLi/cqsn9tr
         2y/EA3N8CfiDIS/OGYidnQ0QUM0H7xCuiWSVeOcU4Wr3QAnIFjv8dUgcR347wEQXi8iO
         VeKfpUT1Q7Ecg7UhzYgu/kl7D5S/J4J9KMzkS5/bBv5vF/k8URItnNx2hgbuPf+My5Z9
         NITe20ODj4Gpqh4jWQaVDXHmUgpeZjUhIqGNqbbJL9fQOtaHTsIDKd6WpEPxPo00TMGj
         aHorpqy5KhSuUZWI/bxPbaWhZDTj60zRldcoml+DCTCvNMWJoPjbcLlOB4VfHqqciojy
         FbZg==
X-Forwarded-Encrypted: i=1; AJvYcCXoyVHoGDZxNGeB8DgX11Ud+MdJLPYeaUrkTJ5FlMEGw5Z1frARc24x0TtJ5ulcT1CfddELvU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfzhSrAwFF6fzYSeysFno2UaUL1k7O3R28ihCebsC+bo6Yp+MF
	F2e4Xc1sH+dakmTfagMQ0+NgIoeEEh/Mpb7toThrhFEfKcrK1myze39fSKR8KBwN4hY=
X-Gm-Gg: ASbGncvFnEd/L7x/bEV2i67byZBZRopZEfDhIygj8yg9eiOtmqO9rutbZz3jmveRcOj
	9Axx7OCIOe+wzEuAWk3Asgxlau8I6+gwToGO06neM+WoHH5vbaMWwVR9RZoPwrg/7Kn1vA06bbO
	c2Z0ERrbXpJhcnEf9HJG7BUFDZ0ViG185WMcCDnewmQFn5xYpmi09MEos7yP2sBmiyITHJrzCv2
	kJnGFkKy2UzGiXK+sOUeXSvL7p4vJxdY8RQXribma9uv4e2mBtZVX2vQ9TMkJ64YdP/nNefW+G6
	ec7A5Re9nQrx1g4hcF/zkHG6LkAdeTcw1eipN7vtGlptgV3MgW/1QkEOZUfb6FSIa3VUbG4hA3w
	R0kHkQpZmzNLfVISU8OCEZakEleVK5+bKgWk+vhTmVdXK2o39C1/zdNlWWpxzC5clSjZ7J79EEj
	s=
X-Google-Smtp-Source: AGHT+IEUw3zyjHs7A3o84CjZmCBIXrtGPiI7xpmvJa8soDqcv+k+oPCPqsIgrIQJa5kxdLcLHyUc1Q==
X-Received: by 2002:a05:600c:4fd3:b0:456:1bca:7faf with SMTP id 5b1f17b1804b1-45a21847306mr39146655e9.16.1755300386881;
        Fri, 15 Aug 2025 16:26:26 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a23e97ca9sm29377105e9.2.2025.08.15.16.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 16:26:26 -0700 (PDT)
Date: Fri, 15 Aug 2025 16:26:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Artur Rojek <contact@artur-rojek.eu>
Cc: Rob Landley <rob@landley.net>, Jeff Dionne <jeff@coresemi.io>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] net: j2: Introduce J-Core EMAC
Message-ID: <20250815162620.17b2fc4b@hermes.local>
In-Reply-To: <20250815194806.1202589-4-contact@artur-rojek.eu>
References: <20250815194806.1202589-1-contact@artur-rojek.eu>
	<20250815194806.1202589-4-contact@artur-rojek.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 21:48:06 +0200
Artur Rojek <contact@artur-rojek.eu> wrote:

> +	struct {
> +		int packets;
> +		int bytes;
> +		int dropped;
> +		int crc_errors;
> +	} stats = {};

You don't want signed integer here.
Probably u32 or u64.

