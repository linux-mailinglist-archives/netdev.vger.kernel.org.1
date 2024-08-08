Return-Path: <netdev+bounces-117039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E594694C746
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 01:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8FA1C2275E
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 23:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D126715ECF7;
	Thu,  8 Aug 2024 23:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsvZmzE6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42675145B3F;
	Thu,  8 Aug 2024 23:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723159035; cv=none; b=VQkb4cHNFKjHW2mjPeyO6+S0yK9LmzbtpjKjcbIURVsWtssAKgc8iqHfn2GY3I5/YewuzBTv0hvp5Vhiq3cpRl4B6WhiAsdIjiF4WEiw0R3l+WZbS3iaX82LQTJQf2PuwwkEJtlYL8mQ9Ckf8noh5FP1XGSEI90d7b/5ae1IsSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723159035; c=relaxed/simple;
	bh=oGZ+fBGsWn2MHHM/NCl28k4CugyRAdGQbp8r40/h/qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQ7nyQ/eM0spjfEC6j71zZ0mTwj1i63IncGJmRHdDbWTM2FYU9PwVf/oQjVwBx5VFANbu5629SE1nFKvtJAd5wCYEoXf7iZYgKb4wx+XId8GbmKh+QQwKeSzw4dRWSeC1GHMFDCqeh/U1P27YgKaPzj4W14aOuVPdoHWgYfBWi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsvZmzE6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fee6435a34so13644475ad.0;
        Thu, 08 Aug 2024 16:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723159033; x=1723763833; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fkIJwEGv5ERA4qnqV+owZl6TafPc0hnN549gs5sTWj8=;
        b=jsvZmzE6NQYLjMzHpT5nub7rlEKFCAU3B/IxoxZyXoo3J0/uq0Z8Jic+NoK9v7jbtz
         ViW07nTV1qOfaVfzoVBGnakjb+iIf5qYNJgkTtmkqwQQoxWpW4oRm0tUOv/+Z2Rafu+Z
         nxcw6rISjEGsOSHcstig7FA3k5Xjk0YD1dVZdlrTYwugqQWKxKHRma5dAb3xbD2EYxWf
         pABRgsuNkfAIuS1Wr7uIIngwm9J56uA4wsyhrh1z2AYfG0fE0NOIgm1uSW2xKIs5E535
         4RQPfgZflLpUTw4ALDCEMvmiXQS15spXc63BcgdQbZP1Tk0y+AEoMm+sBVek3EAB5ApM
         XRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723159033; x=1723763833;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkIJwEGv5ERA4qnqV+owZl6TafPc0hnN549gs5sTWj8=;
        b=t5uNn3LzIHzeanefbs3Jr03ouWjvCSBfmtRxqpitgyfIu5Dr+n+3NiiGHC2ULn6XHv
         VeNhe+1X+0CddxG9UkIcrEkN7pZFVzSa9fppbn/0KQRsAOpiNmxthjaJrduBGGBdzwlk
         qrxf0KP2eYIBgnTz73clenvXkc6c1aP0cyxisDafonuy2633Wmjeee6iWWgRNPts6E41
         lvxWawCbuBkz0oZjhmvu4b7innzCxux5g/YlPEGDH/kNzxgdOAZVt3DlcE45T3/nzoJE
         zrp49MbyuKULucr6wsI7B6rMgbUQOjcBYfyuEdGsr8ylG1PD0xtn1oF73RCnqHTBEDvW
         tVxw==
X-Forwarded-Encrypted: i=1; AJvYcCXFGCRLCp5PG6LLcltopSvyNGhNtjffD3VGrG1uNuJLgTx9TxXusJ23Gm/81H+RKM9RYLlBOv4eCsUyw/fS+gYEHLYLuD75boJCfI8dhcuxm2rJGN1WAgCF5JqyCURsceD6qye+Yc/5gZKzqqHyazgAsH/DBb0Mky1Bq6Wh8SrG7au6ANQMVPeD9Zhr
X-Gm-Message-State: AOJu0YxOdh3PenDAY+dAg2WiSlUV70X3LRf658Y6H3MyKdLRvX/zEODH
	1G1u/6YNaGAUqzO/2hVkwmT6WwIswtiI7ypjOiw6PU8r+xULwzQo
X-Google-Smtp-Source: AGHT+IGt9dfjgid3ag62XkwFWL28kPlGVKGAK1AsromM/qCkJ797VK52SiiGuJf5PhC3obEI0FXB+A==
X-Received: by 2002:a17:903:2310:b0:1fd:5fa0:e996 with SMTP id d9443c01a7336-200952bf73dmr47823845ad.43.1723159033403;
        Thu, 08 Aug 2024 16:17:13 -0700 (PDT)
Received: from tahera-OptiPlex-5000 ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5905ff30sm129461785ad.156.2024.08.08.16.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 16:17:12 -0700 (PDT)
Date: Thu, 8 Aug 2024 17:17:10 -0600
From: Tahera Fahimi <fahimitahera@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Jann Horn <jannh@google.com>, outreachy@lists.linux.dev,
	gnoack@google.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 1/4] Landlock: Add abstract unix socket connect
 restriction
Message-ID: <ZrVR9ni4qpFdF0iA@tahera-OptiPlex-5000>
References: <cover.1722570749.git.fahimitahera@gmail.com>
 <e8da4d5311be78806515626a6bd4a16fe17ded04.1722570749.git.fahimitahera@gmail.com>
 <20240803.iefooCha4gae@digikod.net>
 <20240806.nookoChoh2Oh@digikod.net>
 <CAG48ez2ZYzB+GyDLAx7y2TobE=MLXWucQx0qjitfhPSDaaqjiA@mail.gmail.com>
 <20240807.mieloh8bi8Ae@digikod.net>
 <CAG48ez3_u5ZkVY31h4J6Shap9kEsgDiLxF+s10Aea52EkrDMJg@mail.gmail.com>
 <20240807.Be5aiChaf8ie@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240807.Be5aiChaf8ie@digikod.net>

On Wed, Aug 07, 2024 at 04:44:36PM +0200, Mickaël Salaün wrote:
> On Wed, Aug 07, 2024 at 03:45:18PM +0200, Jann Horn wrote:
> > On Wed, Aug 7, 2024 at 9:21 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > On Tue, Aug 06, 2024 at 10:46:43PM +0200, Jann Horn wrote:
> > > > I think adding something like this change on top of your code would
> > > > make it more concise (though this is entirely untested):
> > > >
> > > > --- /tmp/a      2024-08-06 22:37:33.800158308 +0200
> > > > +++ /tmp/b      2024-08-06 22:44:49.539314039 +0200
> > > > @@ -15,25 +15,12 @@
> > > >           * client_layer must be a signed integer with greater capacity than
> > > >           * client->num_layers to ensure the following loop stops.
> > > >           */
> > > >          BUILD_BUG_ON(sizeof(client_layer) > sizeof(client->num_layers));
> > > >
> > > > -        if (!server) {
> > > > -                /*
> > > > -                 * Walks client's parent domains and checks that none of these
> > > > -                 * domains are scoped.
> > > > -                 */
> > > > -                for (; client_layer >= 0; client_layer--) {
> > > > -                        if (landlock_get_scope_mask(client, client_layer) &
> > > > -                            scope)
> > > > -                                return true;
> > > > -                }
> > > > -                return false;
> > > > -        }
> > >
> > > This loop is redundant with the following one, but it makes sure there
> > > is no issue nor inconsistencies with the server or server_walker
> > > pointers.  That's the only approach I found to make sure we don't go
> > > through a path that could use an incorrect pointer, and makes the code
> > > easy to review.
> > 
> > My view is that this is a duplication of logic for one particular
> > special case - after all, you can also end up walking up to the same
> > state (client_layer==-1, server_layer==-1, client_walker==NULL,
> > server_walker==NULL) with the loop at the bottom.
> 
> Indeed
> 
> > 
> > But I guess my preference for more concise code is kinda subjective -
> > if you prefer the more verbose version, I'm fine with that too.
> > 
> > > > -
> > > > -        server_layer = server->num_layers - 1;
> > > > -        server_walker = server->hierarchy;
> > > > +        server_layer = server ? (server->num_layers - 1) : -1;
> > > > +        server_walker = server ? server->hierarchy : NULL;
> > >
> > > We would need to change the last loop to avoid a null pointer deref.
> > 
> > Why? The first loop would either exit or walk the client_walker up
> > until client_layer is -1 and client_walker is NULL; the second loop
> > wouldn't do anything because the walkers are at the same layer; the
> > third loop's body wouldn't be executed because client_layer is -1.
> 
> Correct, I missed that client_layer would always be greater than
> server_layer (-1).
> 
> Tahera, could you please take Jann's proposal?
Done.
We will have duplicate logic, but it would be easier to read and review.
> 
> > 
> > The case where the server is not in any Landlock domain is just one
> > subcase of the more general case "client and server do not have a
> > common ancestor domain".
> > 
> > > >
> > > >          /*
> > > >           * Walks client's parent domains down to the same hierarchy level as
> > > >           * the server's domain, and checks that none of these client's parent
> > > >           * domains are scoped.
> > > >
> > 

