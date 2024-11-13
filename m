Return-Path: <netdev+bounces-144382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 579CD9C6E17
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 12:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCD2281857
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 11:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FC11F80AF;
	Wed, 13 Nov 2024 11:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCDLeUee"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA531FF7D0
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731498245; cv=none; b=omvBy2inFOQC450ujMfM4eD+wNHq6fgS2mTR7/gzggN16TYdCfCOKWQSs7Yh+lMpItq5Ac98BtHQtvRun5QBTD3l6H5jaLlG+6N/vdeOYmVX53UDDJV8+a9vqQ6hjqOuwByPqhfk+WZpHc/Yoblul/0UvV8tJsNblb6/ks9YyZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731498245; c=relaxed/simple;
	bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=kwY4/zF0CgkAY9t0P83oX3hVKC5+BxP9Fzwlz/L9KUZLxfPVOYRHxv8yNOSho8BxIgh3gzmPNSsHOXmGAlL8/3F65s5ABto0e1RMihryHmgwygOQp8tcRMXvy25kVk39frp1BuIm8IRngJvM22CInwWqMmVyNJ6mX8aGVqF760g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCDLeUee; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d41894a32so362189f8f.1
        for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 03:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731498242; x=1732103042; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
        b=LCDLeUeeIfn93k+5MQy4RzSIpnrkiCb1ufxaXP694zQfInuXIxo6QviZlshBlGR87B
         RUEVxt8EkCgaa9EjgCufgGx6hhSlfdbNlM0r/RJKW1E6Lcxc7t/gUrIuNkeyn+V7n+/e
         xTtZ+qE1oFBQ5eG2dJkwu0upJ24N2HPe2ePXkOGtsFWcFcTEWqbhaXP1HZlgFd3FTStW
         KbsW1uMPXbWPqlnKhbHmjB9Y3Xhqey1Kgi/A+evup3MAr2zv21osa3s9FpkPSZpTONT2
         bFcaC+uPi0fBG7zfRbSuVpiEP0aEnnwR6TsD2nngwYOQojNSzf3QbT8ShzeNISYj4Vuq
         4Z8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731498242; x=1732103042;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
        b=mfgk3/QqvYytkSk4xtG4gzIlgI7Q5QfBBpy+EhLS0T0GpYHNcc2ljC8ZJuMmYMZPns
         AFHmvgNDhJExFBiGsV3wtAOWXvTfMJPhdElrc6JOJVcCuYKACHWUNm+v3fZPly6ObR45
         gXOkSgUtygeQf78oXQrHUPVNpsqHJXQvC4wzM7LBWn67xnO8v/R/lO8nHy03a0Z3atQJ
         w1ObsZGJ7zKF/Wpbc+Ukl+phvykWMUGcrcfuRX0x7+oABWX5dE5hwVjbR8bHXy8LNpvO
         h8SOfQNczNKhtvv9qGVd46wXCbQr+0QzlZSDwoFjfwGiOsbJV8yWOwwgy5TUbKUHWwat
         LF4g==
X-Gm-Message-State: AOJu0Ywih2IdxIKCboOet2pr4Tk2/chRl9RasPyXOBkxGj/quGysoMzv
	aaclFmY7RKWa51/nbnBC1T5gl9uwa5X01kptSib05vxoTQd/BcrKzDJovQ==
X-Google-Smtp-Source: AGHT+IH7jbtsI83/aLmJhxnh5t4z6je6AjZkJ5FgPBOhbgW1GSTH/jsBaJnBZ4kLKKUQjREEAIxvWg==
X-Received: by 2002:a05:6000:1f87:b0:37d:443b:7ca4 with SMTP id ffacd0b85a97d-381f0f5e2ddmr18126167f8f.14.1731498242195;
        Wed, 13 Nov 2024 03:44:02 -0800 (PST)
Received: from [87.120.84.56] ([87.120.84.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea4f6sm18095283f8f.64.2024.11.13.03.44.01
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2024 03:44:01 -0800 (PST)
From: William Cheung <tammywoodhdhfsg84432@gmail.com>
X-Google-Original-From: William Cheung <info@gmail.com>
Message-ID: <425f1f46778e430fcc91915419dc794a12275ef864301c1d15ff1faef6b3fb3e@mx.google.com>
Reply-To: willchg@hotmail.com
To: netdev@vger.kernel.org
Subject: Lucrative Proposal
Date: Wed, 13 Nov 2024 03:43:29 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

I have a lucratuve proposal for you, reply for more info.

