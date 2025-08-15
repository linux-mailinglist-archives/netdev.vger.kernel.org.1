Return-Path: <netdev+bounces-214224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5A1B288BA
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 01:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F053AA4012
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 23:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C892D239B;
	Fri, 15 Aug 2025 23:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjINRNVd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F6F2D0604
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 23:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755300489; cv=none; b=teSwf56iel8KQZOFsP3M3TKpE3zWwYXlO6p1fIEUUykcVSpfhgPBWvZ7vqGUn2SDnn3RWFXfkRyZe33mO6Mc6ty26T6UUjcmnJKu34YlFXQfSA15c8eeiAvPAIHi5JN4FOeeRxjLcptJHrW9c9lrxoQsE3u6T6U6/qyIfyR115c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755300489; c=relaxed/simple;
	bh=lPWpYqFYz2dJsZZehK/jbYqHWrKL0yDezV4Z34jvHKA=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=MrcSXuY5cVz1oRDqpOSnnmcOI68YdoZHSgvLVv6ol7+6h8M/2TCmcw2BkkhaGrRagX2W9PW0rhB9zRPNi8JveaeXSbbKbLPuQkxNU+OIDp41+ZJpXPxf4eNT0nJx9P0Val4xvedUFQTR3Iv8UJqYBVcoYmCYrlWl7U6mH+dpcwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjINRNVd; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2445824dc27so22673655ad.3
        for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 16:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755300487; x=1755905287; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lPWpYqFYz2dJsZZehK/jbYqHWrKL0yDezV4Z34jvHKA=;
        b=GjINRNVdApkc0nVQYt3abkk3C648T1XC/B/38rFPb1KGY4EsMqTzOeXao991+QC7k4
         9Gl8DkXbJimacmwDawyYfxNjdWzfKAb++f816594bDWL7YlRGLkDYNqUhS+y7yyguxJG
         mxjSntC/yRijqK1HpxAAb1uT4QOJuDRTelP/dHqbHu7su811CXvlnKTuOR5hyyPZQjIC
         JBFc5yWkcOJtlX98Q/zwENVprSWuSQt8tU+cqnX7iq7SU7RTt5c0Ehfrdntjm29gJZmU
         aYc47n2FRPzjLv2wfu3YFiw5WNimguZWUNH5uoge6QdD7y7kKr1gYyUBKRs5fuiHCSmK
         vdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755300487; x=1755905287;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPWpYqFYz2dJsZZehK/jbYqHWrKL0yDezV4Z34jvHKA=;
        b=OovkqZGpMSMJPdlnUspZtJb5CoIeH1aYG+zTOoUAgz894Y6zxzegYZgV7mbC5iYirJ
         e5EkkTFH2oHHX5yJQhW0t7voATpDYUf/ab/sMBC36/R/QqvEhNRHVJ+N8szkbG8aJ0Be
         As7zBwIODTufj5wfDbCW5XUFgrdZiTraB2/VGG1CWji0BzGhWkzbwVOVhXh+hure/Ggq
         Wa8TKoJofk0CxXv7rG7dC2icq1hlhXoIKnvmPSuKk08l4SoOEoDVzwAHzS5CYB6uFUki
         mqBC5uKw2NLvur3mHJhKEcSZ/BUhyleVn94TBlk1IsMNNymPrs31JAgKCzjgpvQPvw1I
         xXcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtqcZKsHzsbGJjxi5NT/BCt/ZakRqKIhmM3iQgFZamsRRrmg0LGFoHEzaKEVWyW+TDpsVBKX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCiD/8T7x+qjHKH6HduxoQjEMLRu055hfh6L7Uhr5TcIeTUhK2
	bD/X8NZxbOEBQCIhP/HsAIzEP8MEbn0PW05Zm+9mzhHUoE8+FVBkx4nwevO2ApyUi7Q=
X-Gm-Gg: ASbGncvVvxZ78dss/9lz7yK5QGt1Purkx5oxLr/YJ8SYAzZuHHKAJtGMufmyBGFUlSh
	UQ/kj32eFVJx6QO5oGXuY9zQJikzhcDnYJYsOPnGQMiNRAYMKUW8R9V9ajTOY3lWq/StCoNhwXe
	otA8MLwLJLElk7Wi7JmhBbzUl6vXC/PvMCKEwsaOA2rKV5/SyATL2rk8dqVTKD+L59I3MVLugiO
	dxuljTnQQkehUjvnhdIRehW8CMxZ1xJ7dQLZ1tAnlrtcmwpZt5J7YeQf28O3rMtHSDeV33Y3vdy
	RgP7Pt06wx4g3qppLT0FlSabxAz7p1YYTPxlDUV9SJHzJqbzj5DOqUstt/5xSH4TD6k/FxLR/XB
	tyz6ll5q0TAdVORzW8IibD+Y32Sdmz8wPGILVnT4Pts44lRNg
X-Google-Smtp-Source: AGHT+IHXHB3TO7X15nsWXYNAYCl1sLkjY/Hc9/jeYBtgihwm84ANIgM78G+EvMQ5tc+lnBnSMxvmNA==
X-Received: by 2002:a17:902:e88d:b0:240:2eae:aecb with SMTP id d9443c01a7336-24478f9ea52mr11111435ad.43.1755300486888;
        Fri, 15 Aug 2025 16:28:06 -0700 (PDT)
Received: from smtpclient.apple ([177.189.100.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d59a188sm22513765ad.162.2025.08.15.16.28.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Aug 2025 16:28:06 -0700 (PDT)
From: Guilherme Novaes Lima <acc.guilhermenl@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: Seeking guidance on Rust porting for network driver as a learning
 project
Message-Id: <CE8FAE9A-CC93-4C91-AC07-B6C43B073CDA@gmail.com>
Date: Fri, 15 Aug 2025 20:27:53 -0300
Cc: acc.guilhermenl@gmail.com,
 netdev@vger.kernel.org
To: andrew@lunn.ch
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Hi Andrew,

> Another idea might be an Ethernet switch which is not supported by DSA
> at the moment.

Thank you for your reply. The ideal would be to do something simple, the =
actual implementation of the driver would be the secondary focus of the =
research. What I originally intended to do was to port over r8169, I =
didn=E2=80=99t have switches in mind. Do you think that would be too =
hard? Sorry for my inexperience, I=E2=80=99m a complete noob when it =
comes to kernel / driver development, so I thank you again for your =
patience and generosity.=

