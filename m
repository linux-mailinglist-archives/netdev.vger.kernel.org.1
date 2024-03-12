Return-Path: <netdev+bounces-79333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7622F878C47
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 02:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30CB1C21361
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 01:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F94AD24;
	Tue, 12 Mar 2024 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Ud0ir6jo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BBC4430
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 01:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710207013; cv=none; b=TDN/AE1LaXKIUWyOfNlyiwF4qwDj96tx28DPgz/edCqPsIQagcvTSGHZCBJrrZXpcMpbCln4HcAipHH7aD8AVKpUikFyDfxK0rA0dx7GEnizWGnlaspkeWw7+dtKURqaCL8rv1mnXr9Hr7SRudvgRTmk1UH0qGFXUgml2ultMM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710207013; c=relaxed/simple;
	bh=Yhwbrg8dXkzpSicbSax0azK78ku2wTh8ToGewIpOKOc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwDzeecpEVLb1s4Wb3rGZjHWsHvr2tn/X81uvQfNN1EDldaW0JoDQcS8NwBaGgqNvx1yGIIBNH9Se9HNuCD8H+nbtG3rWlkeSan1ByXNWwMOX3FeFo2y2cFjEpTRcdKDBuPOI2nyoFC2lppv4ho1P4gQtRbrFTNqka2PZyw4cFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Ud0ir6jo; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so3864063b6e.2
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 18:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710207009; x=1710811809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ivwu9CIgTm2rBxaFuJJEcPZ6YSCpmRNHLW0HQhaxaxs=;
        b=Ud0ir6jot1/k528/ofWdVU2A152/o5eTSTeeMLS2lImGOOJj09dBGEFBjtbfvD0yAY
         FU9ABZ42ZTrPoJWymVnX2cC/omJI2GcsPohXWjUt0Ns4YxtpFax7XYX5tsjjG/u7kcTK
         Rvpgvm+KaKdE5TPOPJGoVKIVhLB9PavgQWFeZ3kxhmqYRWaMlKV/wFAaQpP+PEKdNN8j
         e0+9tvYJM3Rj13bTDBZPwaPeaSmg0I/WYehouvV5cQ4Ab/5OiT19Xg1w1qgSnYapE2e4
         fvZqqwg3e1biEhtCCRinwBjSVcOXOseUIiQsMi9eAOeWH8owQz3DGFTNB2pr2srJulxG
         +p6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710207009; x=1710811809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ivwu9CIgTm2rBxaFuJJEcPZ6YSCpmRNHLW0HQhaxaxs=;
        b=qXOcbAYOoiSQsHN3Rs5+ADt7AtjA/KSl/PGMcaVAdrThGZEBZEomrJsdiX7xiGyOgp
         bDk+6pblPMMr5VPQ+lxdBboohNCavUBh8KWJaDVM8KL4dkX6P83tPbPWlgVFVsU+ANL4
         ClMqr9RS5jhpJJl6x3+veFKXDbaP/zpOvjA/UgKCoug4cKZFiUJ8MM4i0zu5hFsBaOoo
         y20k97LQdIi/Jra0nLCCazHFIOiP01/os+QdexaDAeTblJtrWH9uSBHoZ3/sGQis3yfa
         Z598lrsp1N6vkpZ3gfzx73Nsb1xjXwMs5xWnYc8xZbgrzfKmHV50Ly+j3/N3pVU2IZbP
         RIQw==
X-Gm-Message-State: AOJu0YyQtZf5t9hTJ6TVrv5SusxjKi7V0AL2QBUMclAOdPPwpSp+OEA+
	a5Rj6NJ+sE4s4LaRCz8ZVyS4oTlxmnFvfvDPMHZ20hNHDPiChlrPzkmqrV1jEDnbS8MHydfqQ3V
	E
X-Google-Smtp-Source: AGHT+IFzu0+ldzwZ6E9R/D/WZFe9DhyII7Rvjz+vbRzBBXJYlXZLupV9wOyGxFKPUs0MblNOt7nWCQ==
X-Received: by 2002:a05:6808:3d0:b0:3c2:51f0:5f7d with SMTP id o16-20020a05680803d000b003c251f05f7dmr2477550oie.15.1710207009237;
        Mon, 11 Mar 2024 18:30:09 -0700 (PDT)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id r9-20020aa78b89000000b006e5597994c8sm4973116pfd.5.2024.03.11.18.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 18:30:08 -0700 (PDT)
Date: Mon, 11 Mar 2024 18:30:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Max Gautier <mg@max.gautier.name>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] Makefile: use systemd-tmpfiles to create
 /var/lib/arpd
Message-ID: <20240311183007.4a119eeb@hermes.local>
In-Reply-To: <Ze-Fj2RwYnM0WgWi@framework>
References: <20240311165803.62431-1-mg@max.gautier.name>
	<20240311124003.583053a6@hermes.local>
	<Ze-Fj2RwYnM0WgWi@framework>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Mar 2024 23:28:31 +0100
Max Gautier <mg@max.gautier.name> wrote:

> On Mon, Mar 11, 2024 at 12:40:03PM -0700, Stephen Hemminger wrote:
> > On Mon, 11 Mar 2024 17:57:27 +0100
> > Max Gautier <mg@max.gautier.name> wrote:
> >   
> > > Only apply on systemd systems (detected in the configure script).
> > > The motivation is to build distributions packages without /var to go
> > > towards stateless systems, see link below (TL;DR: provisionning anything
> > > outside of /usr on boot).
> > > 
> > > The feature flag can be overridden on make invocation:
> > > `make USE_TMPFILES_D=n DESTDIR=<install_loc> install`
> > > 
> > > Links: https://0pointer.net/blog/projects/stateless.html  
> > 
> > Why does arpd need such hand holding, it is rarely used, maybe should just not be built.  
> 
> The commit introducing the install of that directory is quite old

The problem is that build environment != runtime environment for embedded systems.
But arpd really is legacy/dead/rotting code at this point.

