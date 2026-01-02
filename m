Return-Path: <netdev+bounces-246576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43944CEE765
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 13:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B161F30198B1
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 12:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D5B30EF8F;
	Fri,  2 Jan 2026 12:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="aWse4Gb6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DC630E83C
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 12:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767355819; cv=none; b=Qsep2EyxeGgNNtRSdgCbf7ANPl2aSBPsK7UaYZxYf/ER3E7nax09Sa1dF/JaukL4iuAf/4hTy1MZRkzhIV8QOq1A65TsYU1IDI5gTVB9WOBNCWJVxKjvGOnjksuSgr2d8FjHwIoBf0p1fa/JAjjpK628pmo8NYX4RYkdN7z+ehM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767355819; c=relaxed/simple;
	bh=D3hz3RlW/hBNIlTvBIru3FX1ozhyNkbv1Ma+Wj+so4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsmH3WjOkplfywXwiUrwDlMphmwpjSJyeaI73OynEpyiniIOUykXhnWLebjrZtG4TGNtV9ew+dki9QjiZpV9LOPbyXP8U4suuiNEVl8bRZ1hQaE5/3foUKRpPLkwQJZIXhOLzN8wawZ8JEHgyq6AIQbFdUFNA/bbiJBJ/IfG1aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; spf=pass smtp.mailfrom=konsulko.com; dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b=aWse4Gb6; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konsulko.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64d30dc4ed7so15554531a12.0
        for <netdev@vger.kernel.org>; Fri, 02 Jan 2026 04:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1767355816; x=1767960616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hyAExea92lRqN3+lMIDtFuHcTalaR06svoPNW5R6G2A=;
        b=aWse4Gb6yUVDw1uaPq638k1G8c9WxMtcmi7eBIHQHCyjhM/XOq2LMG9IL+VRjFl+ae
         4i0Pu35cf3599DnqB1xlUUA14fr7I+vyIfgUtar2OyCGJPzUNMldlIOh3FhfDg8VlKGZ
         YVt+oslBEQ5uHl3chDH2E95RBg4BDv4BOJeU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767355816; x=1767960616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hyAExea92lRqN3+lMIDtFuHcTalaR06svoPNW5R6G2A=;
        b=IY/i7gINWvfJv8ipiZFxaNpQPN6flYv3tFa9M1WjiX7in4jqoSwFApqoHlH8HytIpu
         2GzLTXPGyujkK1yxg9ZiEXnQTUqGsL/I2Bz3EA1EFORemgL4xaBxh2iXPVMsWj/y4tLT
         ZGDBUwq1w9z6+YcNE4irR+vSKzsl1aDB5IGHFq2Y/xn8jPQlUFmE9TMmuI0Jyb4MrO3s
         Z7IorJnyl+nyXPDbMX+5ovr9D04wnKbX99bilVPK0UHrn4h1677GmRUEMEdqyWdeITcL
         BlhgUEdlaG2MB9VWLMsYvqtCCrdEzQIaqDA3bTklUXIdpLEopQGFqUF3Rgk7KxyBcit9
         OGDw==
X-Forwarded-Encrypted: i=1; AJvYcCVBJttnDTyJrmlPLigFKFjY5+jj/4VGxjrM/PGzC2zAsPxDMPTi5bdpWijUQeWSJmrCRMJ80cM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJWUo2R5bIJ6LAUKehdLsmk2yvfOpNi1j0vYjcaXjinyvMwl2B
	QUGstfXX/KkSPA9TpxbTqMtJzD9IC5QgXoQ7RuhM3kJzb0vlAF/ofx3stV9HRdMVCi4=
X-Gm-Gg: AY/fxX6RyT2tKB7gDGk/tN8+ZPBfo1BGmUkjF7JZQijJ6ib9TkcNX/5S5QOsA48/NiD
	cNfqrDETY2EpOTsGFLWvRBEaho7U18axdvIr7jrQaEUFkXz+cxWYgLact9ZB6gEqsC9P+kohQ1Q
	9HtWuKVuxOHOJVUvGLaV9yCZqxuTC8O797C0KKRz80fRy/Qbo8MsYIGtAQ6HsByMj4VBN9Rhr6e
	aaY8MgT9d5T7ROXelirJryHSTmf9G6ry2nbzG4vATw2HuVR9NC/QH0jwNF9YaUKq14F4sG4wyFG
	+oTe08TUX3l2VW5HsQmkmuALKMWLOXCeTzT2TtDEi3wbSIWye7HZZX7SeBtQnUtRs8MOG2daNpD
	vb93fy+eH7HXNOkSHlWsE5vS07RMiQO7GZs9FGZQvCgYxL8UsK5T6FbLSxLmbWGSYt/mCTa8J7Q
	vbWK8msT6ECiGqElsJqQ==
X-Google-Smtp-Source: AGHT+IG8H78AqDGUvKh1cti5vZlXZa2v48LQQN927UiarpjJoTYvBWuOyOqu0OgFvo9qewXcWc563Q==
X-Received: by 2002:a05:6402:2787:b0:64d:1f6b:f594 with SMTP id 4fb4d7f45d1cf-64d1f6bf77cmr39880832a12.15.1767355816208;
        Fri, 02 Jan 2026 04:10:16 -0800 (PST)
Received: from carbon.k.g ([85.187.61.220])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b91494ce2sm43342738a12.17.2026.01.02.04.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 04:10:14 -0800 (PST)
Date: Fri, 2 Jan 2026 14:10:11 +0200
From: Petko Manolov <petko.manolov@konsulko.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: usb: pegasus: fix memory leak on usb_submit_urb()
 failure
Message-ID: <20260102121011.GA25015@carbon.k.g>
References: <20251216184113.197439-1-petko.manolov@konsulko.com>
 <b3d2a2fa-35cb-48ad-ad2e-de997e9b2395@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3d2a2fa-35cb-48ad-ad2e-de997e9b2395@redhat.com>

On 25-12-23 12:44:53, Paolo Abeni wrote:
> On 12/16/25 7:41 PM, Petko Manolov wrote:
> > In update_eth_regs_async() neither the URB nor the request structure are being
> > freed if usb_submit_urb() fails.  The patch fixes this long lurking bug in the
> > error path.
> > 
> > Signed-off-by: Petko Manolov <petko.manolov@konsulko.com>
> 
> Please:
> - include the targed tree in the subj prefix ('net' in this case)
> - include a suitable Fixes tag

Sure, will do.  However, my v2 patch makes use of __free() cleanup
functionality, which in turn only applies back to v6.6 stable kernels.

I guess i shall make another version of the patch that is suitable only for v5.4
to v6.1 stable releases, right?  How shall i format the patch so that it targets
only these old versions?


cheers,
Petko

