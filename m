Return-Path: <netdev+bounces-185130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8372A989E3
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 14:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EEDF3B0339
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 12:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E276B215162;
	Wed, 23 Apr 2025 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2OJDLM/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18700219312
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 12:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745411677; cv=none; b=PWsisOypGGf33xOMuLM+fobwL3dylSD1CXZx3bricI72fFrVTczpfC8wAZ9zVKh0krtgqwJCvn0ZI86mkF22j7c50zJjDer7Ih5pTAtoALtT7wv3wgkuikt0Dds8MuMTO8N37L77K++5bVQiiTQKS/0YZWxw9xPpdXSn8PPI1C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745411677; c=relaxed/simple;
	bh=CpUvjtHs2l4PWm2ohr/gQEC615bfrGJMngwgIaadAwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPAWLWNi1pMvEQnNjpt/XKbAi5G3aBBYBA8W2wU/8UNkPXp+XJ6g/FHGv1cQIeWHmbUVPp0ub/oGRdNDvxQhLduJQ9QYVpkLA2fH8kKzfbIDWgdyJ68nAerDXfkM6hUY5gBJa92Lp41OjmRIBqBusrTZ8Wul4dIeoNX039IsVpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M2OJDLM/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745411673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7/t2k2V1RpQt5mnXv9rm5iYX6KyLtMb1CrirX4iYiM=;
	b=M2OJDLM/8lwvbwGBx0J2I2202b/Lu6gdi6fLtb2ON+9D2wAB/YB2+b3lr9Jyq2lCnvkp8r
	qC9PlCBQqIJG44FIGl7BO5Kq6w5ANopqGMRWnfqyYN9uNJwEiOvZUzRBeOek+o0IrcIF0I
	SaK2t0GUKvI4UDLgxBpsHLd57w8I4+Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-637iRegBPpqiWW2lW2v7Qw-1; Wed, 23 Apr 2025 08:34:31 -0400
X-MC-Unique: 637iRegBPpqiWW2lW2v7Qw-1
X-Mimecast-MFC-AGG-ID: 637iRegBPpqiWW2lW2v7Qw_1745411670
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39141ffa913so3124080f8f.2
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 05:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745411670; x=1746016470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7/t2k2V1RpQt5mnXv9rm5iYX6KyLtMb1CrirX4iYiM=;
        b=njtIndnbrKi/BuW1T7KXxjuI4mZiq0RR6xpIFLy8pl8YftEK/qz2SL5FV7U0OqZo/k
         sryADPF2rlI+gLvYINJQMmUUZWx5zJy+XDUeC5t03nSucRhKWAgqgp/aPG1IWkYZTFjR
         sNjki2UP1kgPD3d6GGL7CvnWmlUup2U8RevSPd3hC9D8wXY9/4noTic9Rm9E1bjsTAtB
         J1ewI9aAvtXb12vMO5SbVzqzNtC3Fi+4pw2KO0CPWPWrV1q8YEjUC35XiWDycIIRglld
         4WrNoCFj6BN8WSrTgpAPLApnTYFXoAM1QLoR7Sp+S4IEIxU5TZr2difB1w61TgmFW6S0
         tE6Q==
X-Gm-Message-State: AOJu0YzXLFrl/ouplldZRXoCs3WSmChCZcWJOcOsy4fY+vSF0cPv6wrk
	rO7ii2nqH/z8wyLNiynGZNSorwFb0dWZY0pnhh3qcNJ81GAc3UjuF7GvFkoiC+uiUOGsKG80/rs
	Cef70/w5kk32WamD9ZcP++2kthKN8+F5egcJZqZC0SK8tTVO8JiNDPw==
X-Gm-Gg: ASbGncsMK7ybUu8hAK2yHVSs4SHWZigsxbqZRiW1WO7Tho7upSSYFn8Yfnm5DoDPbRy
	RPOE8oBCvhnrNeks1XjSPhXtVYNW9ZaTRbS+2Cr+pgiTZutzsCA72j18PgVKdlCCVwRk0fH26f0
	aW4+5ICOkrx736wReOvWNK/iYCBJvIZoqxZj0AhbXvDCALroTCaXsQUsAUY4o5lZDhxQ+ogLN2X
	xF4JbGXSQn5e/Yw99qJGQai3G4ODA3LWdFN3QK8ebduJyIC0oeOVin6FLs/BS8lvz9Rqb9suyii
	C7J9fg==
X-Received: by 2002:a05:6000:1862:b0:39c:223f:2770 with SMTP id ffacd0b85a97d-39efba3cd4dmr14953728f8f.15.1745411670368;
        Wed, 23 Apr 2025 05:34:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjf2xRQFYrhf0DTygguo+Q09pNB2qaw8E2wBiwd7a/aPHgyRCRcK67yPvA0BKOGgQoOPwMIw==
X-Received: by 2002:a05:6000:1862:b0:39c:223f:2770 with SMTP id ffacd0b85a97d-39efba3cd4dmr14953713f8f.15.1745411670045;
        Wed, 23 Apr 2025 05:34:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa433303sm18460490f8f.24.2025.04.23.05.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 05:34:29 -0700 (PDT)
Date: Wed, 23 Apr 2025 08:34:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David George <dgeorgester@gmail.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com
Subject: Re: Supporting out of tree custom vhost target modules
Message-ID: <20250423083349-mutt-send-email-mst@kernel.org>
References: <CA+Lg+WFYqXdNUJ2ZQ0=TY58T+Pyay4ONT=8z3LASQXSqN3A0VA@mail.gmail.com>
 <20250423060040-mutt-send-email-mst@kernel.org>
 <CA+Lg+WFSwHD5UMC=vQRGm+x3oG69nDFkJqkbzJy61mOJ+VTteQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+Lg+WFSwHD5UMC=vQRGm+x3oG69nDFkJqkbzJy61mOJ+VTteQ@mail.gmail.com>

On Wed, Apr 23, 2025 at 12:48:59PM +0200, David George wrote:
> Thanks for the response Michael.
> 
> And apologies for the earlier html content.
> 
> > See no good reason for that, that header is there so modules outside
> > of vhost don't use it by mistake.
> 
> I suppose what I would really be suggesting is adding the possibility
> of a driver outside of vhost/ being able to include _something_,
> enough for it to implement its own vhost target. If you don't see this
> as being useful outside of my use, or my case too narrow, then I
> suppose there probably is no good reason.
> 
> Alternatively, what did you think of the suggestion of introducing a
> mechanism of a custom backend for vhost_net? In principal it could
> make the existing mechanism a little neater perhaps?
> 
> David

An out of tree module isn't a usecase I care about.
If you make the code neater, I'll be happy to accept the patch.


-- 
MST


