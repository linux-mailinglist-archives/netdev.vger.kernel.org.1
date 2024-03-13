Return-Path: <netdev+bounces-79720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D04F87AE91
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 19:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 237D9B23D2A
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 18:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7D160260;
	Wed, 13 Mar 2024 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="IsMfkX7S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0DA60277
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349261; cv=none; b=KL66ZPI0zLDiEVrQewCYmftZgY/Tj+YE3IGsx8T2AJyQ1/vZ+6oRig9jnTu3paErqPEl3BDDJNK+W/TKA+C4/47J52TX4rga0OOEystnIQpPjQ+FwTX3r5jyiuFbc/L2y46vZRpph41AG45E7yVSKcUspVIdxtTIR8wP+EIRXUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349261; c=relaxed/simple;
	bh=QA853/51M2V6z21GLQ0hNeCb35G+JLCb7Q0l/p09yaA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uzlkk9Arb0IOkcVgiF30S+9sgtSsIqDyxbms2EM1sglGY+z0LGBqvJidmxtynnyxhTTRURdAJ+TmeNCOEisi4VgkAPjY1p0YujwspFYW04RyTWTrsELFLc5vdqErNBN/SsDsTKCuHngzoSXoneZn61QH1LsRS9HHij7c8pH+4WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=IsMfkX7S; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dd10ae77d8so383615ad.0
        for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 10:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710349258; x=1710954058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kenTMv3VI7rNcYueiGp6Av/1fPTmtYg+OaG3lMlkCwA=;
        b=IsMfkX7SE5khdp2l5M3T8BsYFOnY6UVJXqdIpf9j2q83amZ28prLHQZrx6WzCpnow7
         jTda3IaDoIeaHXj4fsz6gIvOZERI/1uS3qPavdaX7jtkqPWYs0sDYQ0izfpBtrnbOu6N
         FaQTHdWxK28mBjJ7DqP2Ydw7w8E5iZxJvCNZ75Wm+wbImuvpwBlr0xMT/ld1VAK7RCjg
         FpG94ShgLX0TMIx4CTqfZnqgc0r7co95ikbhz9PRTd9Y9zwVqpgqEe+9CU5gDLVfmJPl
         dO/DnFxV416jyoLMoFUxKuQdqNd/ejTbLFM6KQSFceX6ORG+BJDsSQxgCKOuDrUh1JhW
         Zryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710349258; x=1710954058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kenTMv3VI7rNcYueiGp6Av/1fPTmtYg+OaG3lMlkCwA=;
        b=VKslhKxtfZ6wi0uzZEdadYfjVQgtS5bXA5ov4PkEpDkNU+e1UlQS0oxgkJcBiJiAQf
         DWq83hEyDwyK6T7dM5WyC8hHjC/K/Ynad83vUKtehaQlNuoHmfoj5HUWb7eaKOFPCx5i
         /qgZbjXUzIY3zN748iFMiObR3xRHj2enfHMcsiGVxdFVLRYyZIIOd09weuzw6UWKz7gF
         viCgJWrdC7WYcagHdMzOfVdqulKG7kH5sMdxEYUSM99DJ7AFVP05RGclfLja5n22GK7o
         QXfWXTRXbtTQ19yA7ATNxt9RUBUAkw+htLcHAIWNM49cV9vTAKULVFUmXri0B0xma0vg
         RM+g==
X-Gm-Message-State: AOJu0YyXpbKVX+e/bc2yZJ5Ippl4RMTKL00sLJcWEPgocNlV1lXWYZ4V
	P7DArlSN7zGiq+1f7xjlStYnCUdwQiiqD9kao2y9mVHE+V9GnZYOXZvFT6M4qaItVbCU9LuMXNz
	C
X-Google-Smtp-Source: AGHT+IHkre+ZvlX1GvsDIpHaX3Wx/JzSpNz57e+DA4TkcMu1gcSNBup1QkL3g7qkMm1570KOw+/k4A==
X-Received: by 2002:a17:902:db09:b0:1dd:8360:df84 with SMTP id m9-20020a170902db0900b001dd8360df84mr6862563plx.3.1710349258039;
        Wed, 13 Mar 2024 10:00:58 -0700 (PDT)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902654500b001dd652ef8d6sm9076840pln.152.2024.03.13.10.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:00:57 -0700 (PDT)
Date: Wed, 13 Mar 2024 10:00:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Denis Kirjanov <dkirjanov@suse.de>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 0/5] tc: more JSON fixes
Message-ID: <20240313100056.5d583411@hermes.local>
In-Reply-To: <051e50e1-9351-4db3-b62d-e7a042115ddb@suse.de>
References: <20240312225456.87937-1-stephen@networkplumber.org>
	<051e50e1-9351-4db3-b62d-e7a042115ddb@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 14:08:27 +0300
Denis Kirjanov <dkirjanov@suse.de> wrote:

> On 3/13/24 01:53, Stephen Hemminger wrote:
> > Some more places in TC where JSON output is missing or could
> > be corrupted. And some things found while reviewing tc-simple
> > man page.  
> 
> The series mixes the fixes with new features like json support.
> It makes sense to split fixes and new features  
> 
> > 
> > Stephen Hemminger (5):
> >   tc: support JSON for legacy stats
> >   pedit: log errors to stderr
> >   skbmod: support json in print
> >   simple: support json output
> >   tc-simple.8: take Jamal's prompt off examples
> > 
> >  man/man8/tc-simple.8 | 12 ++++++------
> >  tc/m_pedit.c         |  6 +++---
> >  tc/m_simple.c        |  8 +++++---
> >  tc/m_skbmod.c        | 37 +++++++++++++++++++++----------------
> >  tc/tc_util.c         | 28 +++++++++++++++-------------
> >  5 files changed, 50 insertions(+), 41 deletions(-)
> >   

Not supporting JSON is a bug at this point

