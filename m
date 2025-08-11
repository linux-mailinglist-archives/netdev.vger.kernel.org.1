Return-Path: <netdev+bounces-212596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B8EB2165D
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 22:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC48168176
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 20:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE612D8763;
	Mon, 11 Aug 2025 20:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvoPT8jw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6D9205E25
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 20:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754943824; cv=none; b=mlJN1NZvm3YsCsuiyHFJS7LgMSdTWKmOKgW9qyLtEyWYN+5WVcd8yRrtZIry0MbIIbLt7641u8SmcDvjt3ANTTKz8Cqh5hQ+pAOLkhVdjtvexXm9MKbL+wkkIRgIiVCbpkXXHsaWQVY4Gc74gx65kYQEvM6VZgb/Gqr2B2Gdt90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754943824; c=relaxed/simple;
	bh=O9MMJbGuTUHIqUUcd2Fu6+WBYGu9Q/0Pl95H32aD73g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPhB7YZtbFJsJ9wbkzOcbbv4MUD6nA+ZkR6kOWp1ubZBYmEhSqThOiRKxBm30iI6lXMo/yRCXaDzytivvzJGxm2J/qYYDPR9sMpBb/kV1+yd89px3o4b9BjaZt1VWWCs0julnL/I/3t9E4j+l1C7eOfEt0PR9b+7pztbokGpjyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvoPT8jw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-458c063baeaso26478755e9.1
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 13:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754943820; x=1755548620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCUuGIHDdkHPVuqug3k8Q0rvfbFDfnBqIaU13gg8CyU=;
        b=IvoPT8jwIyf88YhHdNyaeeNFyeuCnXpOv4zN3MVb7S0uUc7hs44yWnDQYvyBnx/iwd
         URCIHv+EeIKwex1Yhgl7GmGUCS9xxhIwvA8b5btpKItoh6muIw8KsYcm+F/e/vwgIjTo
         cLuL0STJQjlKdBHhLs01xLMfU5/0A1dyubjB6sb7Pzg0FlVClL4VxvppX6GAogE6q0bp
         chDe7Dt1ygFx6DD1RZ820LxjkdDe7RRiJQEbXf8L6VYaJuHdUAClTSUNZ1yOAAwvkhSi
         o4goUU8da9muMflDzhFDhwMIs/1FrpVOeuEBDwf/CFbasQgziOUVW/ILciNznG2RJ8Yd
         mhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754943820; x=1755548620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCUuGIHDdkHPVuqug3k8Q0rvfbFDfnBqIaU13gg8CyU=;
        b=ntvlGwPQ8Ynkx3eXIgnnOEl0PUyVDMad2l1YDvbStnaE4DQV3ylCYM64Fwb3GUWlVX
         ONW6VV5oiz8b/rMzbQEhleMjcNih9Sg6cJETioxBnd7YciZyaq15738bpbjTMlb2DLtu
         tVRS67eLU09jhBB0RO3379o3z/iHmQd0DmANK55vCz7rTM3IX2jTNNlzjcF2G+5McRow
         ILU56Y795fWZNMioYnu3z4WamMbYOwbJmhH56rmWuhYUU0ElEh+lLlU5FygQQahQiEWk
         pFaYDmgnE8Ajtmqm7PQpqNCpQvVc3N+cwgSU4UAxyLf/cvV42IBPwaURjxtinRhZthKZ
         R/5w==
X-Forwarded-Encrypted: i=1; AJvYcCXN9jAdkit5e8EPiHzcvaWMb5hbSkICDQ3xuSeqYrRwLmFKbKrQ8aatncEq1WPEUA7nvKNN1c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZiI+tfZHw728hODtK4O+cunro1fSrF4Qit8nxjpuG9vYVPy4n
	UoclQf2t/Yo1/noV2tZ2E4PAWkvz+dQz+VPUoAtEyc230B0y62EETP0o
X-Gm-Gg: ASbGncsO7+jCCLkOZaYtc6KFu+anbuJp+jR+S5EO9Mru4RZ5L11EZfHHpfPipWA8oKg
	tJdVpvgIokpB70KswMbN4rEMNiAU4kZ0LrdRpjIDVPxgDcf4Bs7kOByEKFkAnmRx4QkbKEigL5M
	pK6jcyFtd0axnPkVNh+8GV//AZhVlfU2kXLhwBw3Ul1Pn7g2PHOac+mrZ9u1IFy1kOAb8xUS2PA
	00075XmW1wBwbKqAzkiukewtGddvmOTZn7A7McrkUOFPXPVr8mZspK4cTh1WjdfSxzRinghPj8f
	EIQjPZziwSYAFT1/nSxV5YkZvMO/3K/HT1pUvNowLYBrw06SdOJnSKCkdyOFTZoSaCUQetBuiq3
	sGJAFt3ZReP/EXqecPOlgdvrCUMVyR6hZIRcBcxL+s6wpObY2xMu6VfY=
X-Google-Smtp-Source: AGHT+IHAVrPkTtZ260oCq+9KYJfh7SC3dODIukg2FTirbWZJzdnyJ1TDYXqT0nu9enfxCx6STe7vDQ==
X-Received: by 2002:a05:600c:1c90:b0:456:2a9:f815 with SMTP id 5b1f17b1804b1-45a10b941ddmr9975335e9.4.1754943820202;
        Mon, 11 Aug 2025 13:23:40 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c466838sm44068994f8f.49.2025.08.11.13.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 13:23:39 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 5FB22BE2DE0; Mon, 11 Aug 2025 22:23:38 +0200 (CEST)
Date: Mon, 11 Aug 2025 22:23:38 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Michel Lind <michel@michel-slm.name>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH ethtool] netlink: fix print_string when the value is NULL
Message-ID: <aJpRSuCpo37TCLZZ@eldamar.lan>
References: <aILUS-BlVm5tubAF@maurice.local>
 <lwicuyi63qrip45nfwhifujhgtravqojbv4sud5acdqpmn7tpi@7ghj23b3hhdx>
 <aJhG0geDvJ4a8CpS@eldamar.lan>
 <b6unuycjddzrl55q3gwtki2rmm2ituknbmgwpuorgten5xr65w@w4dnhvf6mkoa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6unuycjddzrl55q3gwtki2rmm2ituknbmgwpuorgten5xr65w@w4dnhvf6mkoa>

Hi,

On Mon, Aug 11, 2025 at 10:07:00PM +0200, Michal Kubecek wrote:
> Dne Sun, Aug 10, 2025 at 09:14:26AM GMT, Salvatore Bonaccorso napsal:
> > Hi Michal,
> > 
> > On Fri, Aug 08, 2025 at 01:05:52AM +0200, Michal Kubecek wrote:
> > > On Thu, Jul 24, 2025 at 07:48:11PM GMT, Michel Lind wrote:
> > > > The previous fix in commit b70c92866102 ("netlink: fix missing headers
> > > > in text output") handles the case when value is NULL by still using
> > > > `fprintf` but passing no value.
> > > > 
> > > > This fails if `-Werror=format-security` is passed to gcc, as is the
> > > > default in distros like Fedora.
> > > > 
> > > > ```
> > > > json_print.c: In function 'print_string':
> > > > json_print.c:147:25: error: format not a string literal and no format arguments [-Werror=format-security]
> > > >   147 |                         fprintf(stdout, fmt);
> > > >       |
> > > > ```
> > > > 
> > > > Use `fprintf(stdout, "%s", fmt)` instead, using the format string as the
> > > > value, since in this case we know it is just a string without format
> > > > chracters.
> > > > 
> > > > Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> > > > Signed-off-by: Michel Lind <michel@michel-slm.name>
> > > 
> > > Applied, thank you.
> > > 
> > > It's a bit surprising that I didn't hit this problem as I always test
> > > building with "-Wall -Wextra -Werror". I suppose this option is not
> > > contained in -Wall or -Wextra.
> > > 
> > > Michal
> > > 
> > > > ---
> > > >  json_print.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/json_print.c b/json_print.c
> > > > index e07c651..75e6cd9 100644
> > > > --- a/json_print.c
> > > > +++ b/json_print.c
> > > > @@ -144,7 +144,7 @@ void print_string(enum output_type type,
> > > >  		if (value)
> > > >  			fprintf(stdout, fmt, value);
> > > >  		else
> > > > -			fprintf(stdout, fmt);
> > > > +			fprintf(stdout, "%s", fmt);
> > > >  	}
> > > >  }
> > > >  
> > > > -- 
> > > > 2.50.1
> > 
> > As b70c92866102 ("netlink: fix missing headers in text output") was
> > backported as well for the 6.14.2 version, should that get as well a
> > new release 6.14.3 with the fix?
> 
> I could do that but it didn't seem necessary. If I understand correctly,
> this patch does not address any runtime issue (at least not until there
> is an actual call of print_string() with null value and fmt containing
> a template); and the build issue only happens with a very specific
> compiler option which is not only not default but is not included even
> in "-Wall -Wextra" (not even in gcc15).
> 
> I'm aware that the commit message says that Fedora uses that compiler
> option in its package builds but that's something that can be addressed
> by a distribution patch. Therefore my plan was to cherry pick the commit
> into ethtool-6.14.y branch but not to release 6.14.3 unless something
> more serious shows up.
> 
> But if I misunderstood the situation and 6.14.3 with this commit would
> be really helpful, I can reconsider.

No not urgent, but I hit the same issue when preparing 6.14.2 for
Debian trixie. But I can equally just cherry-pick the commit locally
and then drop it once 6.14.3 is released.

So really no hurry about that.

Regards,
Salvatore

