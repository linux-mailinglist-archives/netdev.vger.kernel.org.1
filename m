Return-Path: <netdev+bounces-198818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08769ADDF0C
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 00:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4FB189C934
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 22:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D35A2F532F;
	Tue, 17 Jun 2025 22:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyYKRfRN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87152F5316;
	Tue, 17 Jun 2025 22:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750199766; cv=none; b=s1vsKhjIUlWo/pv6YV0Y0q2M7klPdndvcB+ICZuLJWrr1WQXoVsdsd2DSHpnN1kQVSdzYm4+IRZo0kCQ2fe4LDXNWaoTOnR2UjqhMsXentFLerMPitEBlnD1VAUY00F8HNFF3oBPOpsjB0mUOEA9NewmhojEram24vbMAqaBxIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750199766; c=relaxed/simple;
	bh=sl26ObIUgcfhCsxOrL5q9KS81TDnKHG7kwchskWJVnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ON6y6kjgh8sws+Wsa/Q4sn6YvfV9SW9UwWkQMI2m7Sw1Pxr93gQ1sb/jRkX9492CpiEudGnlzak7bfT6GozK9TDS1PhPIkGKNcoWLzB2f0nLVswo+rGYQ4YTjach+ril2NQ+x/lqUQbgvTPrQWZZzSlucc7JNnH7c57yyie1png=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyYKRfRN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-235ea292956so57861775ad.1;
        Tue, 17 Jun 2025 15:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750199764; x=1750804564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BslBmwEX63SpkQgXswNn2wvkE3/iV6LHLzaWgxFwnTc=;
        b=eyYKRfRNixW9ErAdvSnpo0L/N3tx8RmVEpH3udJEyJ5driBXxzhg3+nF4V2mAnMdrJ
         4YfliAWna9CwjFezebIVB43I96vwUW49Gmai/euDGgV5y67C+0vB6WDIfrrVCE4sjKhj
         P+diE8W2WDuf7WICwMRpZq8I6lUz0eauSk97W//l6KX3f4onw2gMvfp4fYGk1aGSFXCy
         W7QoYfoyq4ftoZ0XROymtwp0WQak7Mokm9bcn0G1YKARAGL9zeGZ3MnMj53VflxlO2Do
         Qj+S3JPZvGF0xrGHW99nPN7rtgJI6kOkfFG/7CiXin7yv8NoCiJvsKc0mbaSBBZSkP3d
         LEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750199764; x=1750804564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BslBmwEX63SpkQgXswNn2wvkE3/iV6LHLzaWgxFwnTc=;
        b=pyhVWdSt8l4uL295F15JcsY1ucPIQdjriFROG5V76sKoisrF4DGds2BktnvPYvb16w
         cuSxcI80Ung/DZwD0i0PB8Py8yrC08wX7CpzowYSYjEOfWbxXQ+u8179DzY3vU9M7Efi
         htAruKio5yACDWdwP9M/ppKayYWF7TwTgh/KMtk1BGHQ3uewG0bKIeiu95sNVxm94Kis
         9EGX1EaadzOIXT4L52oHXxm7W2p5xn8v97nGFVzykHPivpole76gc6//VW4moULHfkO+
         Uv2WVtzxwPanBkcODNo4siMCr1f0YnHTMPyqW5oa5Se6xUrLYPKEr+kHAlHZoUzHMS4F
         bEsA==
X-Forwarded-Encrypted: i=1; AJvYcCUfZum6sJJXJU3jmCRXRSxPj70eU1uyrjMZMFXAG9SpqDwtHxPvLztM+E1Iy80XqfJTPmUBBZ44wG5qRpLeo6ZDoBxTXsE=@vger.kernel.org, AJvYcCX1LdQdOAeoB+vN3W03xY+ZGbOC3dVQh4/P65dRgxwTR2+hmJ+BH9fwWsUfakJE32Wtg4qWvrUs@vger.kernel.org
X-Gm-Message-State: AOJu0YyGpvObryE28JTpUduLfDm7f9xCjaevKhJNY/CvSjLIBruwKekm
	Q1XX4bPWtWdrO1AOlE4e4bem0fQAmDVG3Qqb9gl2bAxsn3hmI9pbQgg=
X-Gm-Gg: ASbGnct34R3FWfnqU59qUmIrEv261WNRFufxd0qezw1AYa2UYvtr5lMU0VUlorbkGyx
	LIkqw05H6U42LLwWOZ5vl785WM8zeFin6p6DcyB/NVPBi5SKQ2qQZsJgUJdR9RfWNr3UABaEekf
	HuCEMvqHKcgHR2jhlJ5a0LAtjy+b1chU+8/l/rwVXkve6XeHC9oMogUtbOhj5lzFN1R1SPnQcJt
	R1KgeoKtEyK/oT7jnmVMxEWxNmTVvny9mfTOAeP07bqFswqunMMVOrg4xwt1aLOZVE21e8hIRRR
	Z/gDfZut3bbbatax66GWloGkJ4yx1fYbm/vadLw=
X-Google-Smtp-Source: AGHT+IE1PEjlOZHq/6qvvcs7qyAZrObDSTCsfokzw52ipsmbNvfckY8Niwzqd4Rqn6ssyvveSaNZTA==
X-Received: by 2002:a17:902:d542:b0:234:f4da:7eeb with SMTP id d9443c01a7336-2366afe986cmr197072925ad.7.1750199764064;
        Tue, 17 Jun 2025 15:36:04 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365decb5ccsm85988045ad.223.2025.06.17.15.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 15:36:03 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: paul@paul-moore.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	huw@codeweavers.com,
	john.cs.hey@gmail.com,
	kuba@kernel.org,
	kuni1840@gmail.com,
	kuniyu@google.com,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller@googlegroups.com
Subject: Re: [PATCH v1 net] calipso: Fix null-ptr-deref in calipso_req_{set,del}attr().
Date: Tue, 17 Jun 2025 15:35:48 -0700
Message-ID: <20250617223601.14060-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAHC9VhQ0trrgHyJxQOqAQAeN2bCsCx0JeXQgj_xeQbcckCbdZg@mail.gmail.com>
References: <CAHC9VhQ0trrgHyJxQOqAQAeN2bCsCx0JeXQgj_xeQbcckCbdZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Jun 2025 18:08:15 -0400
> On Tue, Jun 17, 2025 at 5:23 PM Kuniyuki Iwashima <kuni1840@gmail.com> wrote:
> > From: Paul Moore <paul@paul-moore.com>
> > Date: Tue, 17 Jun 2025 17:04:18 -0400
> > > On Mon, Jun 16, 2025 at 1:26 PM Kuniyuki Iwashima <kuni1840@gmail.com> wrote:
> > > >
> > > > From: Kuniyuki Iwashima <kuniyu@google.com>
> > > >
> > > > syzkaller reported a null-ptr-deref in sock_omalloc() while allocating
> > > > a CALIPSO option.  [0]
> > > >
> > > > The NULL is of struct sock, which was fetched by sk_to_full_sk() in
> > > > calipso_req_setattr().
> > > >
> > > > Since commit a1a5344ddbe8 ("tcp: avoid two atomic ops for syncookies"),
> > > > reqsk->rsk_listener could be NULL when SYN Cookie is returned to its
> > > > client, as hinted by the leading SYN Cookie log.
> > > >
> > > > Here are 3 options to fix the bug:
> > > >
> > > >   1) Return 0 in calipso_req_setattr()
> > > >   2) Return an error in calipso_req_setattr()
> > > >   3) Alaways set rsk_listener
> > > >
> > > > 1) is no go as it bypasses LSM, but 2) effectively disables SYN Cookie
> > > > for CALIPSO.  3) is also no go as there have been many efforts to reduce
> > > > atomic ops and make TCP robust against DDoS.  See also commit 3b24d854cb35
> > > > ("tcp/dccp: do not touch listener sk_refcnt under synflood").
> > > >
> > > > As of the blamed commit, SYN Cookie already did not need refcounting,
> > > > and no one has stumbled on the bug for 9 years, so no CALIPSO user will
> > > > care about SYN Cookie.
> > > >
> > > > Let's return an error in calipso_req_setattr() and calipso_req_delattr()
> > > > in the SYN Cookie case.
> > >
> > > I think that's reasonable, but I think it would be nice to have a
> > > quick comment right before the '!sk' checks to help people who may hit
> > > the CALIPSO/SYN-cookie issue in the future.  Maybe "/*
> > > tcp_syncookies=2 can result in sk == NULL */" ?
> >
> > tcp_syncookies=1 enables SYN cookie and =2 forces it for every request.
> > I just used =2 to reproduce the issue without SYN flooding, so it would
> > be /* sk is NULL for SYN+ACK w/ SYN Cookie */
> 
> Sure, that sounds good.
> 
> > But I think no one will hit it (at least so for 9 years) and wonder why
> > because SYN could be dropped randomly under such a event.
> 
> Yes, you are probably correct, but that doesn't mean a brief comment
> as described above isn't a good idea.  If you add the comment and
> you've got my ACK.

Ok, will post v2 with comments and your tag.

> 
> Acked-by: Paul Moore <paul@paul-moore.com>
>

Thanks!

