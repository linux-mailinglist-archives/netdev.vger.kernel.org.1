Return-Path: <netdev+bounces-117272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8F794D5AE
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 19:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD29281C13
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 17:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CC213D512;
	Fri,  9 Aug 2024 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXnV+S6E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCFB1CA94;
	Fri,  9 Aug 2024 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723226061; cv=none; b=hh3QuE9NmJGYdIN8B+HjhhfOAA59x/GFU1kDDOae8KPoXa6KYN+GstwgaO5VgMcd6LqKF2+BNRGcZZUX+chdZbIfzi4Cw241pFFRRIccDjTtKkOMrkQlJHruwhPGrkQ7GzBZARPV8mEApMmPFsRDKETkpJiCIw77rg4rHWvbXJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723226061; c=relaxed/simple;
	bh=w9dwPrdglNjb4CJuuomMjEb9PTsCXrE6sDFhrWPwxbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOKwKi+iutcS8YAhYFJPLAGjvsABfcZ+cMXp64uOw53jC0Hw6q9duV60w6u7V4zQT6qHcMMlHl2mpkuXYP/CnYFtmev8fw4SiMYbhMpEepjRvMVG5U0U3RM16yUI99VVB1kiE54oZqA5dZRKoKm88XmrV0tDA5RFR90TFIc/hJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXnV+S6E; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc569440e1so21670365ad.3;
        Fri, 09 Aug 2024 10:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723226059; x=1723830859; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i79kJL7es86O5bR3t8PxNT/TfJeYLRkUdgp0cZ8YJDQ=;
        b=HXnV+S6EW6Hv4B2VTlkxbFrPTbJF5HcrFJAFzYwCm2sOQuVkIPdMhIkD/UqzDAju96
         tRX21ZhWigu7p78DN3gpQLeJUjf7mwPuyqobpInl8e35XFTe7QfAPhzoor6huYccemE9
         dXOFIIFEcsLd/amI6q1heHgbQbNDU1awY4dvc7inW3eowB+G8j8xwI1TfI6wgeeUGowK
         fxHXFWXhvitiQ1HfwEju5VHrrF/DPC3K7ytSfUZQRooY65UPcmEXJ0LYwZ65s9OSWGHk
         NC+K2hifqqWP91u+HLNpQR4CLzVbIByY3bBBLP8pVBp+IwNKIlpfZDCDOY0fkFk86o5w
         cKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723226059; x=1723830859;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i79kJL7es86O5bR3t8PxNT/TfJeYLRkUdgp0cZ8YJDQ=;
        b=e4Cj93V3FQ4DmfOPcwQfrcpqPvFnSKmXY3MpsEg8C64lk20lFOZVLIeVsfjceH6iYs
         lTaS3WnlXj1ndWTS6mie1jDqGcIhvuRy95f7LinskpReXvWow80Iw9MDhL68KGquPb76
         BYnuOnQuP/DYTPtE9uHWJP6zKl0n/hpFansOiLVPmgusnquLW8ZdgC3f+xHqGSKd/cNL
         SAHMiWLo2JKslpn2vjFe9asfE5IMlNMDoIrplCSuDFbcGtkFJOaU63Fu5dZJVvqqieKh
         OzflKltsoXMHfVDEf4XyQtC8zQcmpt7YNxcV3gFb44FYxLw7O9SMuxtZW5mNp1Z3l9Gs
         g2YA==
X-Forwarded-Encrypted: i=1; AJvYcCWGarJA/qCvhunQfAxX4MJsOUict2xOPXiQxn1ARjvK1APvcWMaShlPexKeFtgjDyZJfdgYhVTa2xJRaSziBl/fJLdcQnVUf/he8jl8hRhAlAHRrhw9Tr+WFYdiKblVjj6Pt8jfApXU/QHIrJ7/EAUhXlHBPfWXTC3yR3OBFFhyp0YZzbAd4l0nGQ6X
X-Gm-Message-State: AOJu0YweE/d+zQKGY/ApWKBJHZUStdEvFdf5aYk3F/AAyWFIvv9iDNAS
	c83CwhovPXjyBNOLJjZBmDasFquJyCNjwxSr9zdmdU+OBm/SRXMO
X-Google-Smtp-Source: AGHT+IF6TgRVbkkS/8fWCgztwP8ah68LpZDibl4Zah5cJzKVfLC4DTZHFu319cogK1EsbydUK/ROvw==
X-Received: by 2002:a17:902:d2ce:b0:1fd:9d0c:9996 with SMTP id d9443c01a7336-200ae589d28mr29785955ad.35.1723226059245;
        Fri, 09 Aug 2024 10:54:19 -0700 (PDT)
Received: from tahera-OptiPlex-5000 ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bba3ffc7sm300555ad.244.2024.08.09.10.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 10:54:18 -0700 (PDT)
Date: Fri, 9 Aug 2024 11:54:16 -0600
From: Tahera Fahimi <fahimitahera@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Jann Horn <jannh@google.com>, outreachy@lists.linux.dev,
	gnoack@google.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 1/4] Landlock: Add abstract unix socket connect
 restriction
Message-ID: <ZrZXyGLYSMnpMBfS@tahera-OptiPlex-5000>
References: <cover.1722570749.git.fahimitahera@gmail.com>
 <e8da4d5311be78806515626a6bd4a16fe17ded04.1722570749.git.fahimitahera@gmail.com>
 <20240803.iefooCha4gae@digikod.net>
 <20240806.nookoChoh2Oh@digikod.net>
 <CAG48ez2ZYzB+GyDLAx7y2TobE=MLXWucQx0qjitfhPSDaaqjiA@mail.gmail.com>
 <20240807.mieloh8bi8Ae@digikod.net>
 <CAG48ez3_u5ZkVY31h4J6Shap9kEsgDiLxF+s10Aea52EkrDMJg@mail.gmail.com>
 <20240807.Be5aiChaf8ie@digikod.net>
 <ZrVR9ni4qpFdF0iA@tahera-OptiPlex-5000>
 <20240809.gooHaid7mo1b@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240809.gooHaid7mo1b@digikod.net>

On Fri, Aug 09, 2024 at 10:49:17AM +0200, Mickaël Salaün wrote:
> On Thu, Aug 08, 2024 at 05:17:10PM -0600, Tahera Fahimi wrote:
> > On Wed, Aug 07, 2024 at 04:44:36PM +0200, Mickaël Salaün wrote:
> > > On Wed, Aug 07, 2024 at 03:45:18PM +0200, Jann Horn wrote:
> > > > On Wed, Aug 7, 2024 at 9:21 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > > > On Tue, Aug 06, 2024 at 10:46:43PM +0200, Jann Horn wrote:
> > > > > > I think adding something like this change on top of your code would
> > > > > > make it more concise (though this is entirely untested):
> > > > > >
> > > > > > --- /tmp/a      2024-08-06 22:37:33.800158308 +0200
> > > > > > +++ /tmp/b      2024-08-06 22:44:49.539314039 +0200
> > > > > > @@ -15,25 +15,12 @@
> > > > > >           * client_layer must be a signed integer with greater capacity than
> > > > > >           * client->num_layers to ensure the following loop stops.
> > > > > >           */
> > > > > >          BUILD_BUG_ON(sizeof(client_layer) > sizeof(client->num_layers));
> > > > > >
> > > > > > -        if (!server) {
> > > > > > -                /*
> > > > > > -                 * Walks client's parent domains and checks that none of these
> > > > > > -                 * domains are scoped.
> > > > > > -                 */
> > > > > > -                for (; client_layer >= 0; client_layer--) {
> > > > > > -                        if (landlock_get_scope_mask(client, client_layer) &
> > > > > > -                            scope)
> > > > > > -                                return true;
> > > > > > -                }
> > > > > > -                return false;
> > > > > > -        }
> > > > >
> > > > > This loop is redundant with the following one, but it makes sure there
> > > > > is no issue nor inconsistencies with the server or server_walker
> > > > > pointers.  That's the only approach I found to make sure we don't go
> > > > > through a path that could use an incorrect pointer, and makes the code
> > > > > easy to review.
> > > > 
> > > > My view is that this is a duplication of logic for one particular
> > > > special case - after all, you can also end up walking up to the same
> > > > state (client_layer==-1, server_layer==-1, client_walker==NULL,
> > > > server_walker==NULL) with the loop at the bottom.
> > > 
> > > Indeed
> > > 
> > > > 
> > > > But I guess my preference for more concise code is kinda subjective -
> > > > if you prefer the more verbose version, I'm fine with that too.
> > > > 
> > > > > > -
> > > > > > -        server_layer = server->num_layers - 1;
> > > > > > -        server_walker = server->hierarchy;
> > > > > > +        server_layer = server ? (server->num_layers - 1) : -1;
> > > > > > +        server_walker = server ? server->hierarchy : NULL;
> > > > >
> > > > > We would need to change the last loop to avoid a null pointer deref.
> > > > 
> > > > Why? The first loop would either exit or walk the client_walker up
> > > > until client_layer is -1 and client_walker is NULL; the second loop
> > > > wouldn't do anything because the walkers are at the same layer; the
> > > > third loop's body wouldn't be executed because client_layer is -1.
> > > 
> > > Correct, I missed that client_layer would always be greater than
> > > server_layer (-1).
> > > 
> > > Tahera, could you please take Jann's proposal?
> > Done.
> > We will have duplicate logic, but it would be easier to read and review.
> 
> With Jann's proposal we don't have duplicate logic.
Still the first two for loops apply the same logic for client and server
domains, but I totally understand that it is much easier to review and
understand.
> > > 
> > > > 
> > > > The case where the server is not in any Landlock domain is just one
> > > > subcase of the more general case "client and server do not have a
> > > > common ancestor domain".
> > > > 
> > > > > >
> > > > > >          /*
> > > > > >           * Walks client's parent domains down to the same hierarchy level as
> > > > > >           * the server's domain, and checks that none of these client's parent
> > > > > >           * domains are scoped.
> > > > > >
> > > > 
> > 

