Return-Path: <netdev+bounces-235577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C720C329AD
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 19:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A3E467E6E
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 18:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7503233FE33;
	Tue,  4 Nov 2025 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsN5RuTP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C567329C5D
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 18:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279905; cv=none; b=M6p+Elngquh5pzR4Y5Sb0QWAxvnoKwAHyNMtqIqnMJoHYtNufKmvx5xfLXOW36zldihvvTCT5UzotSdmRgVd4r8vEsaeTcPOzUCNWYWAjS0juza0LzM+k4FuUrQPE1HMtcpf1mEBW7lZc7juxR75tKomjGDvbF80DRPSJJTqptQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279905; c=relaxed/simple;
	bh=pShB2wGmw9UVAjvo4Af9ENCGF7h74zxwzh2zJGAYYVY=;
	h=Content-Type:From:To:Subject:Message-ID:Date:MIME-Version; b=stZHhwx/vEtHSZ/+qdHzZWBLINphbqaip+GfZ2K9dZkrWrk2jf+gGNzuW2Gh+eHJwp+KxhIDpNbenM59x/xfQD0bYsRinlXmsuAkKAdVNBaB2sgy1H77BaRltLyPthYtLMMLJ76guG6xHlo0Qg7mVFXmrtfmjTwcJ47N3LalYvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsN5RuTP; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-477563e28a3so799995e9.1
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 10:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279901; x=1762884701; darn=vger.kernel.org;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :reply-to:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pShB2wGmw9UVAjvo4Af9ENCGF7h74zxwzh2zJGAYYVY=;
        b=HsN5RuTPuLlU8gI8xBkuYyHO42LIdRLaixZ6HO0cH0Km6Hch8ePJsrRRNj+FZXopJu
         EMRYDFL5iSsRSkHawNfbEetr4jb0fW8y8zWGMJ88f/XMd8pnbykcxmLM44Ym4OX2AGbC
         R+N/QUefz4jDBSZRiLdTKKVEB1RpFAprUycxR7v8Uox/Rfq9EZh9QV5XkRkKoy8HoIPs
         Z2T90Xek4wpJU0C5RP++54spSm0r99RLc5erppSkQnR8mVYCFzE6WiKlVhgnL/nBYQxW
         hqALv+sqCETGKxn+bpBp+LOo83Gnvc9Ejiitlny8T6myawg8xS8+4qBRN979rwZ+ci9E
         BpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279901; x=1762884701;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :reply-to:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pShB2wGmw9UVAjvo4Af9ENCGF7h74zxwzh2zJGAYYVY=;
        b=Mk7tcvCpb6IIbKUKpobAXGpNlm25HBtGVu0aC1CBMAOXRp0E5mD9wBJY94IOvjdEB8
         Sk5eS/H/DrRk4o+tTo0qMuf0Nfdqyu26cxWP4JduFDYa9Vy4CUW8aYh9L9p79JgMi87E
         SBDx4vMjSIhbQCkJAT/t4cITIth/MfxfYfSWX/YWNYb7w7IhEN3C7dIxmPZzftFXxh2m
         2yk8K/98Q6HM8rRgV3egm+yCRydtNutEiba+WW+mRJ4AsOFmmMHQWPab7Dmdq5yTrDlD
         Hhu/US/YRYi1MCLoz+l1A+4Ljl9W2MMxQ1C/qrjFHhgGe5NyWXpUopzqaUj39ofQg45q
         rpCA==
X-Gm-Message-State: AOJu0Yz+xVCW2UfLfKNlC2W9A0ohHyGiKLkaq3RXxUnsqseCvhBUDcrD
	NmxaPxsEy/KP9mhGHAiwFPr+i1D2or47Z470vJ57+7QhbdMk4VnqHQJWaE5CNje/
X-Gm-Gg: ASbGncvIXwShqQ/2EYyAXcPLtYo3HShVANx/qlsPewFrPPkD2CVcTnPSsM75o7gJXI6
	Sri3+/MM/hOYdeUP4aORai4PC4LmiWCehWr7Ijg79oy2hTIlSejQUnFt1iYBVZFJgBDlhImUoMv
	u8qImyZ8vqkRcqeqwRXx8C9fJ9L9D8W3zZtBBeNMxYL9WSzbs2tHElgNCqXnVlibnzD3pBE1Aqe
	O3RhtNhWfnbYBqB+Cr57+2S9QnyvsrvKPBFFPkCEPRKqvK1biQqwfXce4lgX7Ai/AeEwnSBqtI4
	01TCHgdeEcdL4IyYSBaKJvNU7RyObeDSSj7KvQrrgki+mgZhqXUp8vqdbUxWD59V3dcyBI+KIM3
	6OctvstV34HTe7vw31xSwGMq8Li+7n6vmr26IQ3CBojP1NE4TGg7fpJqzdLqF4JYDbJT6QaNjfn
	dtzTY+WFIlskgIox6ZJPxDODI8
X-Google-Smtp-Source: AGHT+IGl0kzk8Otu3bgwEPlHcvIQJ9mfCaDZiwOQDO6oeqHer0vYRWezga9VJDrvkdq6mZg0YznBkQ==
X-Received: by 2002:a05:600c:490a:b0:477:115b:878d with SMTP id 5b1f17b1804b1-47754c4ff35mr25490695e9.15.1762279901095;
        Tue, 04 Nov 2025 10:11:41 -0800 (PST)
Received: from [127.0.0.1] ([154.80.6.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdcc552sm2610835e9.6.2025.11.04.10.11.30
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 10:11:40 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: Carl Thomas <liam.intelservices80@gmail.com>
To: netdev@vger.kernel.org
Reply-To: carlthomasces@gmail.com
Subject: Estimating & Takeoff Services
Message-ID: <fd634288-5a60-f697-bd40-f9bd3b7da7ee@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Nov 2025 18:11:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Are you looking to estimate your projects?

We offer construction =
estimating services and quantity takeoffs to contractors, sub-contractors, =
developers, architects, etc.

Get accurate takeoffs at competitive rates =
with a quick turnaround and win more bids. Thanks.

Regards,
Carl Thomas
Marketing Executive
City Estimating, LLC

