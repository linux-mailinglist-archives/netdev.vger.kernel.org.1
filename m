Return-Path: <netdev+bounces-97638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F38998CC7E0
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 22:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC2E1F20F4A
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 20:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0053E145B3B;
	Wed, 22 May 2024 20:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="nN8wF8Sf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71FA7E0F6
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 20:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716411446; cv=none; b=oQ6HNS39nst5ND+kK9Xl/gtznlNdaSy1eTJaAsIko1AqaFbb/jBpeTXlHcNsNcl6TZKAEXkyPYtTz48fakXSD3O1vZAsnpaExDcplVNCYmVGJ/Fks5sFQ9xRH4BYBvyuNUVVfA/9NkHBOh1mCvsZbADawDN44o+EFKWxV6yRP2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716411446; c=relaxed/simple;
	bh=25g5z/Qdokfuw9PoPHe17oXhOdXQL/GdxkB97LI579w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KpcpePagvBn0WuPKDvJ/mpGxtaGCt8rDi0hQ27h4sW6G+AXwJOtLmwWzZZg1M1X3kwRN8kEOB1gEVxvJsteJbcdWknTE9p8XE9fhyiWMdwM8IqxzPi6AAgLmSaVIa0rdPD1TfTTUwBY4EYEFCM0jNui/uRihp7juOv91WQmgQNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=nN8wF8Sf; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-652fd0bb5e6so1663542a12.0
        for <netdev@vger.kernel.org>; Wed, 22 May 2024 13:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1716411444; x=1717016244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25g5z/Qdokfuw9PoPHe17oXhOdXQL/GdxkB97LI579w=;
        b=nN8wF8SfRJ9tYeLXCm0irTDkD5I8zZ3u7yUW7CH+XddPDshKf3XsfwpS7+T/9Pf4Xg
         FcoW0YeXtUKYCwbVPN5Tqxqedo5aG6d8nvrh6fFkeN6ZAxafS+mpRtBBaD3klgmqZkzq
         YcsvYhGqbWOMr5cddyfga0DS156KoUejvo3vah3R33AyrgJ/A+XDTZqOYDZfkO84C9+a
         jtK3y5HKy3H0EiTncazfyXSPnM40QGDVj31ZKQIP9fThjS2ywARUVMtrvpT86EkDMzd6
         e+VemwB5KSB9TXvBY1kNhbOvy0BNftfIDo/Sn9ojHH+vL1yb16bvDkHRLee7LXKOy8rM
         dN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716411444; x=1717016244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25g5z/Qdokfuw9PoPHe17oXhOdXQL/GdxkB97LI579w=;
        b=sL0OuPMah4qVHwkmjs7miuJw2TQK59yDDFA/hmoudYIgK7EwZWqcny2k/ZDXAS3UYu
         gKyhZURULQVkkdlal3SZ/HdNxywYqv0rVr5bXUg8uwvesWqDD6+82W/g/Ad2L5Vhm7wH
         mD0U7X7toulzJQFJr8MHB/rzoRfgthyO3id8xaYwAiV0fW9uX0JjJo4SE05/9Di1E8fx
         CahvC3ga2duZsU7a5dD/tcVnuHEecv2AH7B6D19WY/cGc4QRFX8znmNkvw6cNqUS5j46
         tIXyJtv9wFQIPJjf4gOzfLEHAiWhQysVoGHCWqoaloOxbrqjc1uq2ODXBvCOUlcUh5Ov
         1+Hw==
X-Gm-Message-State: AOJu0Yy3UipeVuIiuB6l+I+okQGzNbEH5971McRxuVx3sV6lYegI7Pj1
	68TSPjEOfbekuZniKLei4+jROY2RRNm4yXjMy/OTsZ18h7fTs/rZojl/LtmQqwY=
X-Google-Smtp-Source: AGHT+IEnP18ItZOInhsr7UUOLJgp3TYvpUP/k1/89YZlpbrPR55C13UnUhZFJD8P/4pVBfhTTdsdXQ==
X-Received: by 2002:a05:6a20:2d09:b0:1b0:180b:218a with SMTP id adf61e73a8af0-1b1f873afb4mr3608690637.13.1716411444052;
        Wed, 22 May 2024 13:57:24 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-63d9a97247fsm19115136a12.36.2024.05.22.13.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 13:57:23 -0700 (PDT)
Date: Wed, 22 May 2024 13:57:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gedalya Nie <gedalya@gedalya.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] [resend] color: default to dark background
Message-ID: <20240522135721.7da9b30c@hermes.local>
In-Reply-To: <E1s9rpA-00000006Jy7-18Q5@ws2.gedalya.net>
References: <E1s9rpA-00000006Jy7-18Q5@ws2.gedalya.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 May 2024 02:43:57 +0800
Gedalya Nie <gedalya@gedalya.net> wrote:

> Signed-off-by: Gedalya Nie <gedalya@gedalya.net>

Why? What other utilities do the same thin?

