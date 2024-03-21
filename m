Return-Path: <netdev+bounces-81127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8952188605E
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 19:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4313A284D9C
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 18:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5692E132494;
	Thu, 21 Mar 2024 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpWSYiTq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29A8E57B
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711044819; cv=none; b=b6MwNE7EWZ0sIWjK+tsMVkcbOxSGISD5z7t/HPNbVmANrZnNmvQixu8nCoALDS9019xTErUitFguLNfIvsg6kP5o7vgSXQiN5J3DGrOoiK57gZLrlUWdVbnI9Z2PfwTNyyNdlYlCZQPGGjWBAUdqY4BPY4hPjIBF98QZV2MHNl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711044819; c=relaxed/simple;
	bh=NeqEFbM/GuBohUeq3XtNKKAHUAoEpwds4r/DXvi3a7E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=SV8ch+UZFbmVgPe+bThCySHTUBhTMKjjE4ni0nIUwSDV4bkPbXt+yvEMAWXlgWrNMaxvoYFQvJmr7ShGmpiRQ8z2uZ/bEHbmlGfPKjZ9o49o17was81nNWUhPatr0R+M0wqlJvElbflSqF38FvcwDh3VlmG6kgoId7XHR+IzP/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpWSYiTq; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-690d7a8f904so21361536d6.1
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 11:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711044816; x=1711649616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWQnoaNGoM6g3Y8+ZCFtXlAiCdEz9aXtDHKGEKH5S1g=;
        b=bpWSYiTq9pFVX7axxIGljA6LV7pLHu6QwLuY/mGzEidfRQOz0LHjlRuYBNiIxBkzFr
         hEqpcRtH6JkAVyBGy4ks6pYL5d8RsCsj10m+lAR0Uaa1Kihpe/gqPGs1zyafdWH2b2TC
         R6JjXGi2hlLU0JqSX5zFGI6CjB9EaqLsRr4tcA5PwvizNC5qe0DKlYLGOfEROBCVYrv0
         JZknVOoJG728JHUyW+cpwi55BXPK7/uEF4cN9fnb9+mssbiQvS3ME4gDI3/lVv+cPFGL
         /aI2GSBfnw6ZKMMnmkGVZO1r+IykS5u3aHf65IYdMGISrFJSq90aU+vFiD0+KZn46N1v
         VfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711044816; x=1711649616;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rWQnoaNGoM6g3Y8+ZCFtXlAiCdEz9aXtDHKGEKH5S1g=;
        b=n7mM5tWbqNrsVJQBZgAgbgHnDFtTEMEMYxdDlHb3VhSpkUiwzkrLecCr9M6DRFuF4k
         Hv456N1uJYRuJaPmtrw6xuD1qXohD0EIMasrYS+ctK0g1dEPgodQdKI483eyv+6KbVF6
         TFo6sGHSkqDoSTNygjJBmLfutWnpwYsVmvzIKCZpve6/KLzSKNX/V5De496L4qJJxNkk
         l8hlXxuDy4uXW47KcLJWreIQv6SH6o1L/jmaEb+ZVUd9A+39PC3H3Kx+ydgDyD4dwA9X
         O6GNYAmkAs88iWTMyl3DXsLAp8er/qKcsVEPEbXNDjNezk+cTZ/b0qGH6jZjRKhexLto
         zlhw==
X-Forwarded-Encrypted: i=1; AJvYcCXZiIKACAzXZYX87fWwpNlI+SsfBIBCeRoqIlBIvpC835TsnmxaIbsXlfZ11kk+rPN37/tBxUqyAmqcfvaweTYv9NE5+r35
X-Gm-Message-State: AOJu0YyBDofV1upRrNjRbMwTvFZw2S1OwwMQXnaNHiRimVJaSCp70dTd
	SUheXqp1rESsDGVKBTd8IFNgl1GOwzk9wU3UXbDLgDlqDqSUOT0u
X-Google-Smtp-Source: AGHT+IHwZtJH/61IVzWoFrrIi603ZfpbR8Dz6mG4eAWWAUesKNpyD2VbAK52iKqKV5l0wKy88OxP7g==
X-Received: by 2002:a05:6214:4005:b0:692:494f:f0aa with SMTP id kd5-20020a056214400500b00692494ff0aamr558561qvb.9.1711044816613;
        Thu, 21 Mar 2024 11:13:36 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id q14-20020ad4574e000000b00690f9ea30aesm138943qvx.26.2024.03.21.11.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 11:13:36 -0700 (PDT)
Date: Thu, 21 Mar 2024 14:13:35 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Antoine Tenart <atenart@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com
Cc: steffen.klassert@secunet.com, 
 willemdebruijn.kernel@gmail.com, 
 netdev@vger.kernel.org
Message-ID: <65fc78cfe99a2_25798a29475@willemb.c.googlers.com.notmuch>
In-Reply-To: <171104177952.222877.10664469615735463255@kwain>
References: <20240319093140.499123-1-atenart@kernel.org>
 <20240319093140.499123-4-atenart@kernel.org>
 <65f9954c70e28_11543d294f3@willemb.c.googlers.com.notmuch>
 <171086409633.4835.11427072260403202761@kwain>
 <65fade00e4c24_1c19b8294cf@willemb.c.googlers.com.notmuch>
 <171094732998.5492.6523626232845873652@kwain>
 <65fb4a8b1389_1faab3294c8@willemb.c.googlers.com.notmuch>
 <171101093713.5492.11530876509254833591@kwain>
 <65fc4b09a422a_2191e6294a8@willemb.c.googlers.com.notmuch>
 <171104177952.222877.10664469615735463255@kwain>
Subject: Re: [PATCH net v2 3/4] udp: do not transition UDP fraglist to
 unnecessary checksum
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Antoine Tenart wrote:
> Quoting Willem de Bruijn (2024-03-21 15:58:17)
> > Antoine Tenart wrote:
> > > 
> > > If I sum up our discussion CHECKSUM_NONE conversion is wanted,
> > > CHECKSUM_UNNECESSARY conversion is a no-op and CHECKSUM_PARTIAL
> > > conversion breaks things. What about we just convert CHECKSUM_NONE to
> > > CHECKSUM_UNNECESSARY?
> > 
> > CHECKSUM_NONE cannot be converted to CHECKSUM_UNNECESSARY in the
> > receive path. Unless it is known to have been locally generated,
> > this means that the packet has not been verified yet.
> 
> I'm not sure to follow, non-partial checksums are being verified by
> skb_gro_checksum_validate_zero_check in udp4/6_gro_receive before ending
> up in udp4/6_gro_complete. That's also probably what the original commit
> msg refers to: "After validating the csum, we mark ip_summed as
> CHECKSUM_UNNECESSARY for fraglist GRO packets".
> 
> With fraglist, the csum can then be converted to CHECKSUM_UNNECESSARY.

Oh yes, of course.

> Except for CHECKSUM_PARTIAL, as we discussed.

Because that is treated as equivalent to CHECKSUM_UNNECESSARY in the
ingress path, and if forwarded to an egress path, csum_start and
csum_off are set correctly. Also for all segs after segmentation.
Okay, that sounds fine then.

There are two cases here: csum_start points to the outer header or it
points to the inner header. I suppose that does not matter for
correctness post segmentation.

> Does that make sense? Anything we can do to help moving this forward?
> 
> Thanks!
> Antoine



