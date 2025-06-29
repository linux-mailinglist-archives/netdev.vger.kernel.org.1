Return-Path: <netdev+bounces-202286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 191B8AED132
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 23:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480CC3B1521
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 21:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B56223BCF2;
	Sun, 29 Jun 2025 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSDtTFhW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF0223BD13
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751231299; cv=none; b=D4k9A9blSelX47zb7zhCHhb1I91Tc2/pR4UxvWeNMdtEpQwF/311P2k57jE7TVlHvQpKDtBQZn8+q5bIbVUMpayqEIp2N/uR87kEzln12ZfEbVFjZZkyAoAvwpJwEnqtq6Z/eQL8P6XBX1CP5kYfTvvPDmnAw8nAb+wClhTujzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751231299; c=relaxed/simple;
	bh=8Jtr1a0AMbnvFSo6RXF5lfHcwUj6EgGlOo8eeCRXn1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbRi8CD9IVhjC3N0gPY9Rvda86nAksBtEu+jbEwN4I3LDT9HB2mZ6YzKFa2NgxFol1HnDO8oa5ZemBz/gz4IINw/OZR4RwyktTWwEEeGqA04fw4Xg/tAgSV7x52ErtiiWlXCtmDvYfMDRwF0sgmgAZmFRy5QKLzfXMsdwGJ1z8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSDtTFhW; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-313154270bbso1337856a91.2
        for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 14:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751231297; x=1751836097; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ftptFlA60oVbaXxpWxPgb3mXBKHNjLkISbQ2O83wJVk=;
        b=RSDtTFhWV8HGd+maw7699XCJXXTfHpEA5TA/unVXoVVqit9F+Vz4ISDH7VE9s5fGzK
         pTY9mvmV63F9ie0+R/L/3Wm9mIbCIFUMm0rob3KWDXt+yLSAasW5TzT/00KLgUuGk8gv
         6WM/hr07stcl75LIWEzz0vKvXpk+enfD3Akll8DfQZeV8od7MztefCdsWuAsde0Xcpxt
         lrntU1aPN030vX3VqyqF/Zs+F+YqlJBi2wYmokUFGy5eoJIP/SwgxNtCrnbCDHxTd5/S
         A73YfzypipUKKacRx5NL+76yiCTU66DaPZ45fLWBzqmoCiHdS9V6s48UoSHFmXe5NxcR
         dyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751231297; x=1751836097;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftptFlA60oVbaXxpWxPgb3mXBKHNjLkISbQ2O83wJVk=;
        b=Cl/G3CllE28RkhA5jmOVu8a4We3bvhWga01wkfJ+/wHOyWQh9L3pjLAghlgtl4pPJp
         o+exIxD/RRrN9UFm1HFjsuWAcnNW12YC2WpEtmnh/5qgjYdiSO3RKHocu7bFXrjB+clU
         RbvclBnSJ1ptUNzTqLm3knA2ZZyVjGx6I0pJnCremVdqa2pjiLX9vSNkbH1vRoCnP6//
         kHFhx6ITsQu7HmoKVv5kZxUUL16T7gpYrzUj2ZIeeYTjH/Z//9To0cLZd6nPMXuQqCDN
         DyRr34Wn/8xE6IkDEAr+9vtLd3ekoI7N/ZPEF6Os2/+/5FX5tSLOSezxPbnRmw+VxdFp
         6gow==
X-Forwarded-Encrypted: i=1; AJvYcCUUl8T90wLjjBa9QcShvRe0+1YejdeE9DUb+zhrU1bi0JIDi5dpgliZbTq7qBgPzJiB5OA5wwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGjJKB2N9EeyHG2hKgi1nI8hXP/ClMLFosEDVjW4H3x3kS1eWA
	uMT3yA5VMm3qQcy07Xcqc4My6STlcYvSZ3UoDg8k2DU+GAhnVLYeGryL
X-Gm-Gg: ASbGncvqnj5O1DfM19Eg4Q0SUDGeLxSXFmKHqPdIHsSX3QHvz5XEA3Ra9U/cMHug2Hg
	oL+JGt6eyw89ZunB5w7Nd8UVSMyJFXD0hexg8wfvQp4UVIyV08cCSxprMQ1MQCxAmula45RXv+u
	0Z5NoUPFXKqatNdE/dKRIsFcolCyQ3Kxvq5AoYdbuBM64t6IMEfDo9s5jTP2Mspw0Q41KG3/5eu
	B6lAqfMiFCE5Wx2EafCY7Qy8IeeWrZzEP7O2KKzqUp4CnqjRi/m3NIvKydVSGMZggIWq0VGUZ6Y
	0Ow0NuJmAtrmXRj7PLN0uRzvmSHSEUwaBRj43/40JLUKOM0MNHjWlDc8oC5Wsy15WU68fDyLbyr
	Hwv9L1WWau4oZMjQTNV/2ZXhK2Q9SrJB+/Q==
X-Google-Smtp-Source: AGHT+IE0HZkYcdb3WF0P9vSez2pBOJhODrzW8f3PmiBl/mDoKnq9PuFfadAntRKfHv3ar4hLYw0Elg==
X-Received: by 2002:a17:90b:1dcf:b0:311:baa0:89ce with SMTP id 98e67ed59e1d1-318c8eed1a0mr20594922a91.12.1751231297379;
        Sun, 29 Jun 2025 14:08:17 -0700 (PDT)
Received: from localhost (college9-169-233-124-66.resnet.ucsc.edu. [169.233.124.66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f5426bf0sm12056065a91.23.2025.06.29.14.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 14:08:16 -0700 (PDT)
Date: Sun, 29 Jun 2025 14:08:15 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Mingi Cho <mgcho.minic@gmail.com>, security@kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Linux Kernel Network Developers <netdev@vger.kernel.org>
Subject: Re: Use-after-free in Linux tc subsystem (v6.15)
Message-ID: <aGGrP91mBRuN2y0h@pop-os.localdomain>
References: <CAE1YQVoTz5REkvZWzq_X5f31Sr6NzutVCxxmLfWtmVZkjiingA@mail.gmail.com>
 <CAM_iQpV8NpK_L2_697NccDPfb9SPYhQ7BT1Ssueh7nT-rRKJRA@mail.gmail.com>
 <CAM_iQpXVaxTVALH9_Lki+O=1cMaVx4uQhcRvi4VcS2rEdYkj5Q@mail.gmail.com>
 <CAM_iQpVi0V7DNQFiNWWMr+crM-1EFbnvWV5_L-aOkFsKaA3JBQ@mail.gmail.com>
 <CAM0EoMm4D+q1eLzfKw3gKbQF43GzpBcDFY3w2k2OmtohJn=aJw@mail.gmail.com>
 <CAM0EoMkFzD0gKfJM2-Dtgv6qQ8mjGRFmWF7+oe=qGgBEkVSimg@mail.gmail.com>
 <CAE1YQVq=FmrGw56keHQ2gEGtrdg3H5Nf_OcPb8_Rn5NVQ4AoHg@mail.gmail.com>
 <CAM0EoMnv6YAUJVEFx2mGrP75G8wzRiN+Z=hSfRAz8ia0Fe4vBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMnv6YAUJVEFx2mGrP75G8wzRiN+Z=hSfRAz8ia0Fe4vBw@mail.gmail.com>

On Sat, Jun 28, 2025 at 05:26:59PM -0400, Jamal Hadi Salim wrote:
> On Thu, Jun 26, 2025 at 1:11 AM Mingi Cho <mgcho.minic@gmail.com> wrote:
> > Hello,
> >
> > I think the testcase I reported earlier actually contains two
> > different bugs. The first is returning SUCCESS with an empty TBF qdisc
> > in tbf_segment, and the second is returning SUCCESS with an empty QFQ
> > qdisc in qfq_enqueue.
> >
> 
> Please join the list where a more general solution is being discussed here:
> https://lore.kernel.org/netdev/aF847kk6H+kr5kIV@pop-os.localdomain/

I think that one is different, the one here is related to GSO, the above
linked one is not. Let me think about the GSO issue, since I already
looked into it before.

Thanks.

