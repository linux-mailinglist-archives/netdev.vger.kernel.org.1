Return-Path: <netdev+bounces-143897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E87A69C4B00
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 01:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1F601F231F0
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 00:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26781F7068;
	Tue, 12 Nov 2024 00:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="XtuK8EZ5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7261EABBB
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 00:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731371711; cv=none; b=r+VxIBG5pH3snJzSIHnCoWrxZn4If0yTTde1JeuPG2rXs+0xqfUYYR36Wzocbya2mOhCYNQPQYgndM9f1NFk7AXepmSowTK4MGnlbmMeJvxseq38tLT8KMUUxnPsDiRsvqQUEs9i8vaTVCuUOxELJa1HONLy8GrMgMUUIQWuPK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731371711; c=relaxed/simple;
	bh=PkbyTMgFqOzcboehWlrrNjFh8Q2ib415gbHXRRFnbKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHG/VOVj408i+ydn/VFAwBHNTgh6MxF/E1yp/4dwwtRqv7ZBkKWkKwavnhS/AB9XBRu9tNvpfeRfgBJCPkHRyOmlHXDLIQLYIk8FvuW7lxPuhfoGlmIg9OOGcx2Ik8Avb55X9VV0sS84YkZMq40hfIjHj6RZmMZ9suCnqW7ENeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=XtuK8EZ5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20e6981ca77so57860285ad.2
        for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 16:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1731371709; x=1731976509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKgRrgLp424rRp+9+I/8Qg6L1UWiV8NeCx/IXJG06O4=;
        b=XtuK8EZ5k0B8EVS8lRpTMmyiSJxFc1EDkFbTXoxtx9vK6MIba3rfrQYXjWN4wCFgNl
         KVmV1YCHOlYfFs91bgsD5uZfXAX2RtJjDeT5rAGeWRHZS5wdYsjwH7xLuEdpLPFcbS2i
         0IFXutOvz/P3fbHTY9RqSw8+v7wu2cqAI6sSRjsB9m9KrgMI+7BhShgk+hVKxn7R12Gw
         FvhakkkgAhhjzy9SjtneVLmShHgl8tPNP1GUspDLXlM4IUJswOKOb9n1DzDBRptwLjXd
         oNS9iSJ52FDxMepWV3f7L+2kvu6QuoeEdICOfnTthmTbqKslZ2P9BqzkPrw2Wp2twy07
         xTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731371709; x=1731976509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKgRrgLp424rRp+9+I/8Qg6L1UWiV8NeCx/IXJG06O4=;
        b=fUMQpwYkYlBbLUylgqT/jmfVgzwa+G4wDZ9GrPbyA5xr2AMH9Dv6tvoObTnBGnwp9y
         3HTgtChpHaHsDbgs/i7M4yLXHw3YrykZrKfJlTxUJtdjAxTn+9D8SQ1CI/50QiZikzO7
         6nl4qbWeeYGJLgJY+z45qs8iOvbOYhAdigKEAWSvUQ4VIz1QSWj3F0xMw5iyPyI/jkBr
         YOgHZjiW/wkZHpxndgP23n7+3aKmbUeF5/KPgd0vJvF+Ww1edE48VHVCMx/MW4cc0rGh
         EWeMRckgNr+XqHD4mgkhrG/ZqwgoKolZB3Py3z88H/cONqsdBw+iXaLkUwKsGGNosAMa
         FMSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeMo6kXd8rQNo+ujMTbLYzHNebTk5RIp9AFbpXqsWvmCms/Ez7lNpKkklM+bl8kIqej5DmNcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrJJyJxMenTVPfRuciGnRf3GwGwJr/oJoIZX8HCWXOhE0U9rmv
	fq9gayovwEsQ0UOQE1wHjxB63PO9+dH8nGa8f+7mvKBbCk02qA2s1ILOgwkA1Rg=
X-Google-Smtp-Source: AGHT+IGQTUP7sJ930EzsgxemjH6kwFcSH2PpZgSrP5gAgxNP+jgwhKNTZv9LbZwLWAoEXjOkZzUgZw==
X-Received: by 2002:a17:902:d4d0:b0:20b:ab4b:5432 with SMTP id d9443c01a7336-211834f2d6bmr134631535ad.12.1731371709530;
        Mon, 11 Nov 2024 16:35:09 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc8376sm82809975ad.44.2024.11.11.16.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 16:35:09 -0800 (PST)
Date: Mon, 11 Nov 2024 16:34:30 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
 linux-pci@vger.kernel.org, Ariel Almog <ariela@nvidia.com>, Aditya Prabhune
 <aprabhune@nvidia.com>, Hannes Reinecke <hare@suse.de>, Heiner Kallweit
 <hkallweit1@gmail.com>, Arun Easi <aeasi@marvell.com>, Jonathan Chocron
 <jonnyc@amazon.com>, Bert Kenward <bkenward@solarflare.com>, Matt Carlson
 <mcarlson@broadcom.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Jean
 Delvare <jdelvare@suse.de>, Alex Williamson <alex.williamson@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 1/2] PCI/sysfs: Change read permissions for VPD
 attributes
Message-ID: <20241111163430.7fad2a2a@hermes.local>
In-Reply-To: <20241111204104.GA1817395@bhelgaas>
References: <f93e6b2393301df6ac960ef6891b1b2812da67f3.1731005223.git.leonro@nvidia.com>
 <20241111204104.GA1817395@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Nov 2024 14:41:04 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Thu, Nov 07, 2024 at 08:56:56PM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > The Vital Product Data (VPD) attribute is not readable by regular
> > user without root permissions. Such restriction is not really needed
> > for many devices in the world, as data presented in that VPD is not
> > sensitive and access to the HW is safe and tested.
> > 
> > This change aligns the permissions of the VPD attribute to be accessible
> > for read by all users, while write being restricted to root only.
> > 
> > For the driver, there is a need to opt-in in order to allow this
> > functionality.  
> 
> I don't think the use case is very strong (and not included at all
> here).
> 
> If we do need to do this, I think it's a property of the device, not
> the driver.

I remember some broken PCI devices, which will crash if VPD is read.
Probably not worth opening this can of worms.

