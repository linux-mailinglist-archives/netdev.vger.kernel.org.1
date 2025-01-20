Return-Path: <netdev+bounces-159782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AE8A16E0E
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 15:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D863AAA97
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 14:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB871E32C5;
	Mon, 20 Jan 2025 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4N1L8ja"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5396195FE5;
	Mon, 20 Jan 2025 14:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737381664; cv=none; b=Cc5qJBXXBK61dDFMGKD1CDvJ0wgliu36TuLUh0euV8n6dkdWEzPXwZ81/9lb+TBmh2CNi46eJ1AW78O8g9+fwIGVJVAhNPfvxP2sa4z1d6SHXq7xy+keccDwe64xytNkg+1FkmikzHHhJ9Pb8Dsao5xWboOmaznhEmfiIowiMFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737381664; c=relaxed/simple;
	bh=IcQ3eVnulecyaqloc5aSZA1CZ9NHEMiHG06KvYdwWes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7i0S6zRC883cSiPK20rJbtGZpTKPpkiSOwBfQQ6HTfkdrDwefn+OGGT3KJZsU6k6Omgn04hyWgij9nDVg8HRRly9ZBKwE/prw60kSaaTIMPi4FR6t1LdcmxA3r4AR/ysJFVWzgJ5wkwykxothezr/7fZFShmZ9dwTM1EkfCTt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4N1L8ja; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53e3c47434eso4574022e87.3;
        Mon, 20 Jan 2025 06:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737381661; x=1737986461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jR+uP1Yocm87B3tpfs04OTLSeEE1gYTWyRGrCv+cYJI=;
        b=F4N1L8jakfr/no9hbBBh+AeSkqzEhpN8Hj1fyYwIar8lnlkhWOp/2GSi7CyNVwIF7d
         XZaBShpr8i7LIDmReahzEi70pxx+y111PaZhDCQa6iLGopr4iFveMg4k4zYtyVUsj+Js
         t3TJMFqcAg2kJbPTTVc5nSrSY0XsbvF/0SpGrHm8Jjt1nW6p//5E4RjQvycIaZkylJOY
         2JlUmLXvBZN5fpT+k5n/vnXlaAq6gWIVhsMtEOCcmlCvZXTAexglTRAkm797mmxg3hkw
         iDaHroVgI3ED8nqUNzzresrOJC393mAE1BNBwg6ZGBbf3Y/6oWFLC362sfljyfxxfvPh
         3OEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737381661; x=1737986461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jR+uP1Yocm87B3tpfs04OTLSeEE1gYTWyRGrCv+cYJI=;
        b=FbwKjC8z5VKsndkBIEqGxoYYfirB82/JFCvhkj/OGRFwsfk4oSFYS5Sm/GcgeUmPEH
         w4rvP84/vtOnfQXQktTfJ4+6u5lKr8+0GYWcv/MkcB/3sC7ZuE5Ny88ghnmJtPtyXx4c
         qKngxS8s/gzmV91/vCV6KvY8lYUugx4mUSlPyDqQQ6d1g4iAoQxhEwgEgH/U2lfXTa9z
         78Pkf8f9gTL41J/pbtNaby+IdYmemlWyA4ALUPr/ZGCk4PLZFWD2dRXwzJtf7AVO8UZR
         C9R2w8TBw+Py+YdYJGFieufTn6EmmcNydPDzY1WEFP1WL72RRPoReufMrUTmk4Sq8Awo
         HoTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqQDG/noja6efU9YF+7PRQ99E3pcprEqVwvQ9D+C4cJRmDW3BqsZeO6lh44wgvnyDKQiGGI+0Pb+sPcSY=@vger.kernel.org, AJvYcCVfcq39+WubmDZEJXcfcfS6RiPwvP30b6ZULIRODpuUBJTMECWWk0UyMcUrRXzMSGYXEPxzPz8F@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj3U3ustcr7RBVOr67sB19UkknUfekZswZMdHNsVZx0GOkLMWO
	pIdPAogrFxnWsuLlNjPMvwfrIrpFw6kmgz+C5VWtiCaZIggvk/Zi
X-Gm-Gg: ASbGncuS8erYUKuP5Z9tb6MAeCiOEpd0OtqngJOszmHCvc8bbO8Arzdd51JhaAR/yGf
	qVGjxSR68XYbjVvlgRjTjdP4KXAnTDmlqMSzINcdgIK5enEMf/kgMmXE8J8/o+UpER2svC9NalC
	MkEvROoEVFtrLyX9Gct5ueQbcgxDAeUMlwbWYL1TVRlU1mli/WhGAX7OR8aoH6c0TKqmkkabx2/
	8y2Mc0rz1NEEwHjgRnIT2Hf7a7+FTWk4FOHdz1QZ/w+BOBKWApriyfbNSyT+MFNZyeggGpvedkN
	Z3DwJp0q
X-Google-Smtp-Source: AGHT+IHIxW+OjSwEUyR3XS8fQW4dfIIo/Uq2O0VSA9P+UOB4MxztylX8y2NFTS5b69fsSnFcLEXZaQ==
X-Received: by 2002:ac2:4c05:0:b0:540:1d37:e6e with SMTP id 2adb3069b0e04-5439c26753fmr3525312e87.33.1737381658979;
        Mon, 20 Jan 2025 06:00:58 -0800 (PST)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af60c5bsm1366418e87.148.2025.01.20.06.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 06:00:58 -0800 (PST)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 50KE0sYf029288;
	Mon, 20 Jan 2025 17:00:55 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 50KE0rJ2029287;
	Mon, 20 Jan 2025 17:00:53 +0300
Date: Mon, 20 Jan 2025 17:00:53 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: Eddie James <eajames@linux.ibm.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
        edumazet@google.com, davem@davemloft.net, sam@mendozajonas.com,
        Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: Re: [PATCH] net/ncsi: Fix NULL pointer derefence if CIS arrives
 before SP
Message-ID: <Z45XFfduLMkp5iga@home.paul.comp>
References: <20250110194133.948294-1-eajames@linux.ibm.com>
 <20250114144932.7d2ba3c9@kernel.org>
 <Z4g+LmRZC/BXqVbI@home.paul.comp>
 <97ec8df6-0690-4158-be44-ef996746d734@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97ec8df6-0690-4158-be44-ef996746d734@linux.ibm.com>

Hi Eddie,

Thank you for testing the patch! More inline.

On Fri, Jan 17, 2025 at 03:05:24PM -0600, Eddie James wrote:
> > > On Fri, 10 Jan 2025 13:41:33 -0600 Eddie James wrote:
> > > > If a Clear Initial State response packet is received before the
> > > > Select Package response, then the channel set up will dereference
> > > > the NULL package pointer. Fix this by setting up the package
> > > > in the CIS handler if it's not found.
> >
> > My current notion is that the responses can't normally be re-ordered
> > (as we are supposed to send the next command only after receiving
> > response for the previous one) and so any surprising event like that
> > signifies that the FSM got out of sync (unfortunately it's written in
> > such a way that it switches to the "next state" based on the quantity
> > of responses the current state expected, not on the actual content of
> > them; that's rather fragile).
> > 
> > Sending the "Select Package" command is the first thing that is
> > performed after package discovery is complete so problems in that area
> > suggest that the reason might be lack of processing for the response
> > to the last "Package Deselect" command: receiving it would advance the
> > state machine prematurely. It's not quite clear to me how the SP
> > response can be lost altogether or what else happens there in the
> > failure case, unfortunately it's not reproducible on my system so I
> > can't just add more debugging to see all responses and state
> > transitions as they happen.
> > 
> > Eddie, how easy is it to reproduce the issue in your setup? Can you
> > please try if the change in [0] makes a difference?
> 
> I am able to reproduce the panic at will, and unfortunately your patch does
> not prevent the issue.
> 
> However I suspect this issue may be unique to my set up, so my patch may not
> be necessary. I found that I had some user space issues. Fixing userspace
> prevented this issue.

That's an interesting observation. Sounds like you're probably sending
some NCSI commands via netlink in parallel with the in-kernel
configuration process (this detail wasn't at all obvious from the
commit message) and that races somehow.

But in any case userspace shouldn't be able to crash the kernel, and
responses to netlink-initiated communication should be going back to
netlink rather than getting handled by the ncsi_rsp_handler_* code.

So there must be some insufficient locking or a logic error somewhere
worth fixing, especially since you're able to reproduce.

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com

