Return-Path: <netdev+bounces-195452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6D9AD03B6
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 16:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFDA77AB4D1
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 14:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCD3289804;
	Fri,  6 Jun 2025 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="bgDlFlz3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B62288509
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749218509; cv=none; b=AFDPYMM3QSjJ9f+hkx9Qscaf8aslPJUV7gmHQMwSvmQu0Y4g/asAIji9G8NmMNdW5oKc4e/B7VRbWaUWOteJJ/Agr9E+jJ3+W9gRTVi4QGyZHjM7alp2mkgICr+SM3EaSX1/GtPbxnYL9s4sCN98zhSUf40IqxsYLfp5jHcub7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749218509; c=relaxed/simple;
	bh=Jv079A1mKhODOqlAi4r6uhqMp0P03cTtDVyzAdBmdG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLiOW91uGqAk/b2OMOMVzIRJzkArEu9V5bbZhFJYHsfzfPd3j6NHuAR3kxm4WBc8C8vrSYriK/YzZvC/8xuL7IwWlwkcr/lb0LA7A2Dcu1jJ0BswZeOFURPZOCYJtNaqwFZV/Qfgsyka3PLAbvA84uzzjw76PfAWt6n/tMxbibE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; spf=pass smtp.mailfrom=konsulko.com; dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b=bgDlFlz3; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konsulko.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-604f26055c6so6390666a12.1
        for <netdev@vger.kernel.org>; Fri, 06 Jun 2025 07:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1749218505; x=1749823305; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yVy/wIBnGTuazkJCwaSKpZhD2D1xF2N5FE8GQCPBb34=;
        b=bgDlFlz30v3mwfrxfNvoH2K9HSjEF2GGPOaV/mGu2NOclfeM9G0K+cVW0fSUuYr/dv
         OKusDLEJaWVQ51Ny4pZViF0LsGZSjiqkst7+T+p/0Go75R5j42+GAn9uiQovt9B8YQ9K
         Xx6IB07zyni1SlhnZZTBn3zIN68eqbofE1+Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749218505; x=1749823305;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yVy/wIBnGTuazkJCwaSKpZhD2D1xF2N5FE8GQCPBb34=;
        b=VbL6VA2htSUfjW/oDvJ9q/m48l7qWdgMe37BEwPyBPearslu+UQvoPKHEjCtEyYz2K
         a7d7HJwpWt3Vc/8SGOv8QXibhIDnPe76K9eXK//b2eyXoKv6geAaaXYHrzNv7+h06jvi
         6mbz+AMwV3OdaBkT3uZ5U4bvfyoUCwB0DHSBj9Xqhr1Wj5oy9sJXEmgn5V0qZSFBKvQ8
         rTJa6M9Bza1VlYtLS93J4aUaUUic/7gxNFXlfX1ASrSnkK5HENCKTwIb2naKllFKtYrU
         Nke5U9+oGOugcgNRHnWwsr8XaxASa+NBn78lC2NL1f1EclqMujmvS6pYVfkikZZ+aBkV
         GCrQ==
X-Gm-Message-State: AOJu0Yyz+52rTakHAdQHHSbA8To2X2ks7SlbuZUGeEMtjn2c/8aFcchP
	A/mhsSDQf0FaSPZ8AEawyYYMhTNsSVat2imtF5OuLM0zFb3Pmpesv91zsRqOolXRVMc=
X-Gm-Gg: ASbGncsusOvnAY+kYIOjv9oLklg/5h4x8JFMdI3cswwlrz/Pp8fH8gdVN1QiWPV7P4D
	brbDVpAJFDqUPBxSKxM/IL/hGYWs7dxS9xPhga0Q9T+wYCGAuXUM/CG1X4ZfROEwX/bPjI7EGLD
	kggpX3WuMuFbkvggTWmJnPCbIID1ohfVfJf2i2SXam1r9l/WSthKMYFnR5s5gN4eSWe4PY8VdAG
	XXG8HK+QgVFsCHeaJV0PR03l+9j3YQzy4Kza7ZmH77KhMbTWodxJpN5XPtptk8wTncYkPAmpXlf
	Sy0ycAnlHGslmZ527Njh14JJCDOA6pEXuKxCwxzrq29d/MgccQhH3XeZ8w==
X-Google-Smtp-Source: AGHT+IHG/4qJs2s/NLNq61Xjqy6GoVpJGhFjRwUlTlRpB7R8UYCwmZOGJ0hhr1720d7lgxldsPdx6Q==
X-Received: by 2002:a17:907:3d05:b0:add:fa4e:8a6a with SMTP id a640c23a62f3a-ade07606d5emr757395766b.10.1749218505160;
        Fri, 06 Jun 2025 07:01:45 -0700 (PDT)
Received: from carbon.k.g ([85.187.61.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc37ae2sm119484166b.112.2025.06.06.07.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 07:01:44 -0700 (PDT)
Date: Fri, 6 Jun 2025 17:01:43 +0300
From: Petko Manolov <petko.manolov@konsulko.com>
To: =?utf-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>
Cc: netdev@vger.kernel.org, David.Legoff@silabs.com
Subject: Re: wfx200 weird out-of-range power supply issue
Message-ID: <20250606140143.GA3800@carbon.k.g>
References: <20250605134034.GD1779@bender.k.g>
 <2328647.iZASKD2KPV@nb0018864>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="GekoW/mEyP+WVXm0"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2328647.iZASKD2KPV@nb0018864>


--GekoW/mEyP+WVXm0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 25-06-06 14:13:18, Jérôme Pouiller wrote:
> On Thursday 5 June 2025 15:40:34 CEST Petko Manolov wrote:
> >         Hey guys,
> >
> > Apologies if this has been asked before, but i've searched and didn't find
> > anything related to this problem.  So here it goes: i'm upgrading the kernel of
> > a custom stm32mp15 board (from v5.4 to v6.6) and i've stumbled upon this when
> > wfx driver module get loaded:
> > 
> > wfx-spi spi0.0: sending configuration file wfx/wf200.pds
> > wfx-spi spi0.0: asynchronous error: out-of-range power supply voltage: -20
> > ... a bunch of "hif: 00000000: bc 04 e4 15 04 00 00 00 ec 00 74 76 f7 b7 cd 09" like messages ...
> > wfx-spi spi0.0: time out while polling control register
> > wfx-spi spi0.0: chip is abnormally long to answer
> > wfx-spi spi0.0: chip did not answer
> > wfx-spi spi0.0: hardware request CONFIGURATION (0x09) on vif 2 returned error -110
> > wfx-spi spi0.0: PDS:4: chip didn't reply (corrupted file?)
> > wfx-spi: probe of spi0.0 failed with error -110
> > 
> > Needless to say that v5.4 kernel setup works fine.  The only difference with
> > v6.6 is the wfx driver and kernel's DTB.  Now, i've verified that wf200 is
> > powered with 3.3V, in both cases, so that's not it.  I've also lowered the SPI
> > clock from 40000000 to 20000000 but it didn't make a difference.
> > 
> > By looking at the driver i'm fairly certain the above error is actually coming
> > from the wf200 firmware and the driver is just printing an error message so i
> > don't see reasonable ways of debugging this thing.  In short, any suggestion
> > would be greatly appreciated.
> 
> I believe you should have a trace with the firmware version (starting with
> "started firmware x.x.x"). Could you provide the firmware versions?

Here's what i get with the new firmware:

wfx-spi spi0.0: started firmware 3.17.0 "WF200_ASIC_WFM_(Jenkins)_FW3.17.0" (API: 3.12, keyset: C0, caps: 0x00000000)                                                  
wfx-spi spi0.0: sending configuration file wfx/wf200.pds      
wfx-spi spi0.0: asynchronous error: out-of-range power supply voltage: -20 

This is with the old one:

wfx-spi spi0.0: started firmware 3.12.2 "WF200_ASIC_WFM_(Jenkins)_FW3.12.2" (API: 3.7, keyset: C0, caps: 0x00000000)
wfx-spi spi0.0: sending configuration file wfx/wf200.pds      
wfx-spi spi0.0: asynchronous error: out-of-range power supply voltage: -21

Apart from the error number the rest is pretty much the same.  Both dumps from
using wf200-v6.6.pds (attached) as the old .pds won't load on v6.6.

> The issue appears when the driver load the wf200.pds. Can you provide
> the wf200.pds you used with 5.4 and with 6.6? Normally, you can't use
> the same file since the format has changed in v5.17.

Attached you'll find both, old and new, versions of the PDS.  This is what i
used to generate the v6.6 version:

pds_compress -l BRD8023A_Rev_B01.pds.in wf200-v6.6.pds

The old one used '-p' instead of '-l', but this is due to the format change, as
you mentioned above.

Thank you for your time, Jérôme.  Much appreciated.


		Petko


--GekoW/mEyP+WVXm0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=wf200-v5.4.pds

{a:{a:4,b:1},b:{a:{a:4,b:0,c:0,d:0,e:A},b:{a:4,b:0,c:0,d:0,e:B},c:{a:4,b:0,c:0,d:0,e:C},d:{a:4,b:0,c:0,d:0,e:D},e:{a:4,b:0,c:0,d:0,e:E},f:{a:4,b:0,c:0,d:0,e:F},g:{a:4,b:0,c:0,d:0,e:G},h:{a:4,b:0,c:0,d:0,e:H},i:{a:4,b:0,c:0,d:0,e:I},j:{a:4,b:0,c:0,d:0,e:J},k:{a:4,b:0,c:0,d:0,e:K},l:{a:4,b:0,c:0,d:1,e:L},m:{a:4,b:0,c:0,d:1,e:M}},c:{a:{a:4},b:{a:6},c:{a:6,c:0},d:{a:6},e:{a:6},f:{a:6}},e:{b:0,c:1},h:{e:0,a:50,b:0,d:0,c:[{a:1,b:[0,0,0,0,0,0]},{a:2,b:[0,0,0,0,0,0]},{a:[3,9],b:[0,0,0,0,0,0]},{a:A,b:[0,0,0,0,0,0]},{a:B,b:[0,0,0,0,0,0]},{a:[C,D],b:[0,0,0,0,0,0]},{a:E,b:[0,0,0,0,0,0]}]},j:{a:0,b:0}}
--GekoW/mEyP+WVXm0
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=wf200-v6.6.pds
Content-Transfer-Encoding: quoted-printable

PD=11=00{a:{a:4,b:1}}PDA=01{b:{a:{a:4,b:0,c:0,d:0,e:A},b:{a:4,b:0,c:0,d:0,e=
:B},c:{a:4,b:0,c:0,d:0,e:C},d:{a:4,b:0,c:0,d:0,e:D},e:{a:4,b:0,c:0,d:0,e:E}=
,f:{a:4,b:0,c:0,d:0,e:F},g:{a:4,b:0,c:0,d:0,e:G},h:{a:4,b:0,c:0,d:0,e:H},i:=
{a:4,b:0,c:0,d:0,e:I},j:{a:4,b:0,c:0,d:0,e:J},k:{a:4,b:0,c:0,d:0,e:K},l:{a:=
4,b:0,c:0,d:1,e:L},m:{a:4,b:0,c:0,d:1,e:M}}}PD=3D=00{c:{a:{a:4},b:{a:6},c:{=
a:6,c:0},d:{a:6},e:{a:6},f:{a:6}}}PD=11=00{e:{b:0,c:1}}PD=C0=00{h:{e:0,a:50=
,b:0,d:0,c:[{a:1,b:[0,0,0,0,0,0]},{a:2,b:[0,0,0,0,0,0]},{a:[3,9],b:[0,0,0,0=
,0,0]},{a:A,b:[0,0,0,0,0,0]},{a:B,b:[0,0,0,0,0,0]},{a:[C,D],b:[0,0,0,0,0,0]=
},{a:E,b:[0,0,0,0,0,0]}]}}PD=11=00{j:{a:0,b:0}}
--GekoW/mEyP+WVXm0--

