Return-Path: <netdev+bounces-250340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DECD29086
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 23:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7338C301B2FA
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 22:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AE13203AF;
	Thu, 15 Jan 2026 22:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvXh5HF8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D5526F291
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 22:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768516352; cv=none; b=f6Q4t6Hyr05mrMTmMr+xlliBJULm1GjXQBsaigD+smffyiIxKEqiecxmJaaRwrfPVnWiys8OamJhVUk0gcEN1RCofBtpnAmYkOrgM/3Dj+/cq9dtL2+4G6KW2pF8Hcfv2OFNW5djXpFFzKXkeiJ+6CFYEYSZj/ZjUnr1Iz3yUK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768516352; c=relaxed/simple;
	bh=RVSsbvnzcTskaSr4JxPP+QTDROhjoiuxQ42GIhG1hE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1imOtc0twX+YIWpFqdpOm0sg41NYtTZMKtlR0KhpYFliNf6RYv2xOAkZLvsMVvHjPyd92EtvsiOixho29w5jnWRzAhOwWw+0DR5JCWLPn5a1KJFjMYITvvV4TZShwRFRgcyVLI0MGflgHAi1RJW8hjz3mYKpFHkaX129quA7xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvXh5HF8; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b86f69bbe60so206316166b.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768516349; x=1769121149; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ERhpIfe0KAnH+I0lEftkXUyHU4cnivju7fTaghPhTpk=;
        b=BvXh5HF8habEtr2XKDZ4NmSoGxBSjm2SZQx4uNCkslz0ACV9ixI0Rper9LDCPclFUC
         xlxSdqURMvZ08e50VQK/EUOgaMpd4F+ZDFsCz4Jbkyj0Xh7uxexD2YeGe6vmZFEqL0pD
         mOCqteOiv0a+gkaX1jWJaqv+dRN8Ucvr24d1eKdDji4dOdPC120uMHuJ5m5/riXlrigM
         uR0Qg+i6oD/n3SeVazQGbkShp9HsxUR+2zxZlqoPuXw9G/THaSrn5BVOz21bj8bw67DQ
         4L0OjdcCOai6I2PHxRtEfCHH66k4/t7IursNNh1dKAMf43Vyr4/VsP2bTgj+3eFw5UNI
         cZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768516349; x=1769121149;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ERhpIfe0KAnH+I0lEftkXUyHU4cnivju7fTaghPhTpk=;
        b=hX2ZJ584JYv9C+l2QvxB1XaAK9RSu4G0wQwrIPCbPceyXdom7yQRQ4oNI+1DtUzSdb
         o2Pg/g9twPjTeJt5PC0RO9tiOhvTV5M2+0tI4Ku8W30PsfGXcj8tXc8os8QqprYwUagQ
         8xPgyMA9Tawyh5FUKd1clZIcBdNVJr3lakvRsUCmlQ9j2LV5iFOEyqgiNJQDKHb03vcU
         wqwCh6NBUoE8oC+Kkx8UUXBds20ZuWIH7DpLCMRWbqupdLV0jEr1apLolLG4XRDwLGAW
         M3VtV/VCf7CYQ9m6RXERlisdBCWECtwndiwJwGziZQxRUhXszvAu8PkEQfDF7vJb9AxK
         ACPA==
X-Forwarded-Encrypted: i=1; AJvYcCW2+zakHzYliXn8X2dpo7BkLdf/ygBX8zoWnf9CKlFsM2jdvvvQEQgXR9MHS4I8gwt+XD8OMCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzginulU//Z6mT7VBRfCr4nixR9XNAnM7h9Fih6rahOXcgSn8F/
	Jj/zahOJs0zwRUZbIszUNWiyW2paKSlp3Ktgovj98knGC4Ks92JLBosW
X-Gm-Gg: AY/fxX63brMj5hl+OUpXI1eh35sYt8qfD1MPZgSJNUXpZjb4Np7fQsvlVfhW6kjYyrp
	O0cKOMQCpFdmatFOKxUrEEa9IqSAGRGr+cReaen1VBb6u+4+kOs7dTc14xl+LE5ujPsVWy47BVA
	om+ZdniI1hZVv0adHQzXvREnfTaffm9h3PCcXs4Hy7TU8g5PB1uYDIhaa1Cl5+ztUhEnhtJ8iNs
	hqxbdIxrgls/oed4QDQHA09DJQVwJLaZ3iTc/TVqviG+PNPgPxFyjMf8I4JEu5O4h0QgAimuFcI
	mmYTivxnW7awnlNugJh8jbDisxl/RzUO54Y7cTAgJtf1bC+x/RbcsKaYFcN2V0IqdF5e21cWbnq
	Saq9E8IHtWn7ciJ2vuYV+dWX7dM/npgrYL7Tdh5Ahum2ndzoq5dfiNkVspwUABOhh1E26Xw82e1
	SI5MmUvSZb4whPbon+eYeFz0/u70VC0jMl5mlp
X-Received: by 2002:a17:907:1c25:b0:b87:1048:6e21 with SMTP id a640c23a62f3a-b8796bb3de8mr41587966b.62.1768516348976;
        Thu, 15 Jan 2026 14:32:28 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959c9fb0sm54856766b.43.2026.01.15.14.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 14:32:28 -0800 (PST)
Date: Thu, 15 Jan 2026 23:32:21 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>,
	Christian Brauner <brauner@kernel.org>,
	Justin Suess <utilityemal77@gmail.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com, Alyssa Ross <hi@alyssa.is>,
	Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 1/5] lsm: Add hook unix_path_connect
Message-ID: <20260115.a6f842555347@gnoack.org>
References: <20260110143300.71048-2-gnoack3000@gmail.com>
 <20260110143300.71048-4-gnoack3000@gmail.com>
 <20260113-kerngesund-etage-86de4a21da24@brauner>
 <CAHC9VhQOQ096WEZPLo4-57cYkM8c38qzE-F8L3f_cSSB4WadGg@mail.gmail.com>
 <20260115.b5977d57d52d@gnoack.org>
 <4c3956c2-4133-46bb-9ee5-4abf9bf7fff8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c3956c2-4133-46bb-9ee5-4abf9bf7fff8@gmail.com>

On Thu, Jan 15, 2026 at 04:24:48PM -0500, Demi Marie Obenour wrote:
> On 1/15/26 05:10, Günther Noack wrote:
> >   I would prefer if the correctness of our LSM did not depend on
> >   keeping track of the error scenarios in af_unix.c.  This seems
> >   brittle.
> 
> Indeed so.

Thanks for the support!

> > Overall, I am not convinced that using pre-existing hooks is the right
> > way and I would prefer the approach where we have a more dedicated LSM
> > hook for the path lookup.
> > 
> > Does that seem reasonable?  Let me know what you think.
> > 
> > –Günther
> 
> Having a dedicated LSM hook for all path lookups is definitely my
> preferred approach.  Could this allow limiting directory traversal
> as well?

No, this does not limit all path lookups, in the sense of what was
discussed in the thread at [1]. (I assume this is what you meant?)

The LSM hook proposed here is only about the lookup of named UNIX
domain sockets, as it happens when clients pass a struct sockaddr_un
to connect(2) or sendmsg(2).

–Günther

[1] https://lore.kernel.org/all/81f908e3-8a98-46e7-b20c-fe647784ceb4@gmail.com/

