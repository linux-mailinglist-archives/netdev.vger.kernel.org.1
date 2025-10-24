Return-Path: <netdev+bounces-232650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED4EC07A86
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD0E3A501E
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 18:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F24C254B19;
	Fri, 24 Oct 2025 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyBW6PfX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1559D346E5B
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329475; cv=none; b=uqz+cSbzQesb5C9TAnMXAIFO2Tp5S9hwM+DId1lZUMhMb+gEwFrdLXmammSX+0NZ6+YpoV43ZxEfHWLJ6vL4FQU1ingjWOgUjaxoiHcgzy/0NUJePlZa4NL1oo/L+zorPcRnw3AWTATzh28z1VN+NfpnpUcFY5aYYzL03D0Iylo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329475; c=relaxed/simple;
	bh=bMYyMRYYx63usGZcxhgDTyUi63gOzISxxw+njEnKuUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnHft47G8pgTlKTR5GGI8LEHIMFP42OgO6q1UIoqEZNoZ2AKHpCDW1V7cADhwZcQvi53IkhJ7e+L/2jPJJDh9vT9QfVn1AEpb/7hc4Wwjp7IaHiaCpABcnrbyLz5CV9EAlCV3Q7C2KcXvWDX37d5nEHUBpLDNxFVT0g2485pQ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyBW6PfX; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b553412a19bso1532988a12.1
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 11:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761329473; x=1761934273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JdBb9lC3u7xEME0W3SXgZb4MmUAFksfdfBLRlWCIW2k=;
        b=kyBW6PfX1ci8GdZZ1suXIC6Uu84624aGxWlENkQ8I5D4jILmJj8QcbdRhVw81couQx
         yNy33ljvcCgCJ0e/jqu5f7l2dylih01bDOWjN40lQUcp41ln0+HiMo9LNJVKrEa8Oyzq
         gVEOLaASh4W13bqEMmqiql6B8WVuZe2PNuAK39QdM2tBVMHJuo6oyppwSiJ/Zgq7eP5/
         KkSy75BVakUI1vwGVZiqPRC/5gF4FunpvbQb4pTvy22ReVNwIvXq9Hjp+kurIRQyRfPT
         FKMua0VFZAkfMHPAQpUnMjSTyjX6lyShfKB349XH1hw731ruCude1uS+SexJA+FtqYf4
         Hu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761329473; x=1761934273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdBb9lC3u7xEME0W3SXgZb4MmUAFksfdfBLRlWCIW2k=;
        b=lLZ5ueoCjmg8+jrWT6VKLZJ3Eq6P7eTdREc0q/7GS626GOBDQX3rWV4xKrC6kmgq46
         jrhG2abKOOXpcYC0KviGP9U2pmpRCYb0emICF0y/PhJTENi7JFEqS/ld/JexBRGC7bbw
         wM+Mn6j+bBF2UZ2Kb8leMHolFTL6uE9Fnd5MMsceoGPfeOIrGMms+T41qdLhqQJAhOCz
         bUwITx8YDUB631+qCrUFHG60bByRY+qd9xq/xRnJAKzYHQ30W9DO/LAUZ3KuvQbEMG13
         iYRcIdg0o3yrPK8MYSNdqjTz7vRlNUzagodbbVdKtCX5JDKnBfe9BPQpe/8ftPxdDH9T
         RmcA==
X-Forwarded-Encrypted: i=1; AJvYcCVC8AtzFhjxJW1tn956lJVGYfDIiLsQ0z/KiovCOnKPB8ayGJffIZ7v/1F7DUOYQciGdC1qS9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzby/UujJgdOTPMfKZiFoHOy+/HqfDr3zV0pDHEe6w6j9/HGjWs
	YkgrQPEtQgRbxyEuWQy1uzlzuQuBpD08XbiZSZ/lnwHKK5Hiac8WIUc=
X-Gm-Gg: ASbGncvmqFhUCNtEc73nnDxRYp5e6tZTf/kakU1nPoVQyXEtTXCEYsEqUSeTntk7PiM
	A6iz4uWS9WWoT0wHvY66VTu76Cu3HOayi/VYcJ5bwHCoM7OyV+92jP/emQPTGDKPgXQ4BthCrXp
	+6F0ASFfjnsBe6OcXTv9uV/GHQRK4B1xU8kYLw49pjhfJPye72Qe3U7A52rD34S8OCmp5qTE+Ka
	Z1qtmIqZAF2de39Ws1koxsYjMJQ+SBEkf3jAHprXkvoic0+g0UmlF+a/i7axaq5sF6JBN9fT7OV
	zVfJUVFtmpKJsy1fPMXfbB1guN+cTI6wA0nyKd0SyNHAM6X5/AQmqnZltRbeQjkYYldbvNCUdGB
	gQetD9DYFxQ7Dt+LJfomsHMZwk0OYrlNvODmb4bvjOAWGKMauutHPRO1aWvofLdOfJihtNjobCR
	jg0lP2Us2ASiq1BbXcDFU0nowQMeBlZFjnI/GHXrJlWo0t0+jf0k4DeqaEoPRyzbcEdcOSvpa5X
	oZGAOh4GW0fIvXgX71sR6Rm/aoQRSinzFxZRgTU+IlFtzbvDHe5aEKIHHDH74TIVyg=
X-Google-Smtp-Source: AGHT+IEnquZZ3WWeLP3I5w3hVGHiZ7NabHapZYUY+I27WMmRanZ2oSutfHqVIc6+kSwOgCVCmqzk2w==
X-Received: by 2002:a17:902:dad1:b0:26c:87f9:9ea7 with SMTP id d9443c01a7336-2948ba78fd1mr48423245ad.59.1761329473016;
        Fri, 24 Oct 2025 11:11:13 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2946dfc1314sm62440755ad.58.2025.10.24.11.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 11:11:12 -0700 (PDT)
Date: Fri, 24 Oct 2025 11:11:12 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, davem@davemloft.net, razor@blackwall.org,
	pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
	john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v3 01/15] net: Add bind-queue operation
Message-ID: <aPvBQJ6FUN5X2kMW@mini-arch>
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-2-daniel@iogearbox.net>
 <20251023191253.6b33b3f4@kernel.org>
 <c93a71ea-fddf-4f0c-9a01-ca5f1729037a@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c93a71ea-fddf-4f0c-9a01-ca5f1729037a@iogearbox.net>

On 10/24, Daniel Borkmann wrote:
> On 10/24/25 4:12 AM, Jakub Kicinski wrote:
> > On Mon, 20 Oct 2025 18:23:41 +0200 Daniel Borkmann wrote:
> > > +      name: bind-queue
> > > +      doc: |
> > > +        Bind a physical netdevice queue to a virtual one. The binding
> > > +        creates a queue pair, where a queue can reference its peer queue.
> > > +        This is useful for memory providers and AF_XDP operations which
> > > +        take an ifindex and queue id to allow auch applications to bind
> > > +        against virtual devices in containers.
> > > +      attribute-set: queue-pair
> > 
> >        flags: [admin-perm]
> > 
> > right?
> Oh, yes good catch! I've just checked for other instances in that file, don't
> we also need the same flag for bind-tx? bind-rx for example has it, only the
> info dumps don't. I can cook a patch for net

IIRC, TX side was non-admin-perm by design (because it only references the
binding for tx and doesn't need any heavy device setup).

