Return-Path: <netdev+bounces-250902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF19D397B9
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 17:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B44930065A0
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 16:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E52D221543;
	Sun, 18 Jan 2026 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o6XaMVfe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADC1212FB9
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768752662; cv=pass; b=Ezy3jf9BVZtgKH0148GSOp/7CxeQdX3utk9wYVVPuTMltfuy8OD0Cgh/t4Wo5k2IHULZZNR1TbqfdeUzNGz7AT65bTwG4IT8DYZFW9HW8X6oNr8NSDX4RXuKQXwg2ab5ArOKC95G6y/y03Pd4LKdPEdskLJV+bUrvfr1sFh1ThI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768752662; c=relaxed/simple;
	bh=0JEpv1u8AAklgZXOaUjF/uve3gSlITzDcBypad/O0O8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2fIhadTKQRSA7mZFRdf/0kQdLKMxzxoWWrE5/ZprubLAtCBzcI8nmUlg1/mqU7hAmo/FjciHQPloqctx5L+0NpSWA6zwEMRWKTl9vmNgnkn8Ia3buK0Vnmxt3BimaDwkFhbug9lpL+QPSpXGc3rym1RBhGXFLj7GJa/8gW3nBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o6XaMVfe; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5014b5d8551so537051cf.0
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 08:11:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768752660; cv=none;
        d=google.com; s=arc-20240605;
        b=lfwGEL2KDECvbc0Q+4z4T9EF8X2JKFqCANgI6z30rhfijgPbOMXPam/MI3OG+Ij1G5
         TE9KtQIOUPzfl2rvLijNuyX/agF2qVOzKQ0UGcnRIA8u+2jwuWyB2O2jsaeLHm1sK1kY
         BFVGildLFBo539+tZza+rqlkyACf7RHdAHdc1WGLvrfDD58wts+1IuxH2nDPPs508qOg
         a+aPKyUw51BPvcU4TdbvMkxdo7totUr5fkmOVOrGnF7jYb1D4mdb2ljYuQUFc2qMFMow
         V0KGwegv1maNdQPIRPwtX9UAg1FU+h3W7v7TxJrNJicqc5Ri5s1T6ERDkwyQ1XNC5GNe
         NC+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uOQOX9EFLjUIlu2BazfXCgVYe+lL7//UbrC4sKaqc4w=;
        fh=O3QgLnXiZawwODhfBVwiiK/CwrnnDvEM5NYkmOltsIs=;
        b=Gqy/jmcCcD+m81I5guCcunkwgVzI+hfCGdiEgmcE8bXU5V5d6NKR0/B/66NhVF2jKM
         Blmvy8dwS1sDflfDMVBfvc4XeHW4akAPxc1v7fIjbeKdYz/F9x3t/YcR5CYpCC2sJgaM
         ACSlYTC206PKOckjOh815lbHHkhkhta9tnGiZMl/miihW7jCi1SztRzcRkI1uKwym+b+
         Tuz5Dup4NEuCeznZZjfKeVMHmXR2cx7D6nSSPfRKRXfOdtrv96iOl4JVT32WiPETf+sR
         OmQszcy76VTYSjsMaPVJC4w0k2L4Iz6ZuJ+TYqbiwtdy9JSEbWfDcjpCnoD6RIm1ST9h
         zQIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768752660; x=1769357460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOQOX9EFLjUIlu2BazfXCgVYe+lL7//UbrC4sKaqc4w=;
        b=o6XaMVfeClkjpRcSgzZz6ylPmhY4DzRtt9TKBZgcXgb9UBFd4eGSJy3wouiKYeoxFZ
         +dS00Qq+oyGb1YwCrkvooeHOr0y5bV/hGVGwIrhbmVGkcVH7PJJE01wr4anVeqSzQobf
         66NZEO7pbzaQftNGzUWh5O3JtHyWCC902akFDKCQpxLgyZ6/jUTmUbQZh7C3HUevO5TP
         3337NTE9Mu43ev+xQsctB1vLMjQUe4Lp4pAsQvhCUNp2qJNn5Sh9fDkSfXpcKoCJMUhP
         vTjHYNT/7aXvP+tzo0d6oAVG6NGcAwRdBd4I9+waz5sVmzsYBPC+suwxJvrX4W3lIf6Z
         LO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768752660; x=1769357460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uOQOX9EFLjUIlu2BazfXCgVYe+lL7//UbrC4sKaqc4w=;
        b=J8zIDINEPqR2sY6YUuWq7GgdQgWF2q0hjDXPUpQ66wYyx5GRPtf9fXv+AEZEeabTFQ
         dtiORnR03B6MuUPBAyf8kNatkC4Ya9iwoCNqz2TAh++ySxvQFnzJxIITUMQEOSZ9Ghj2
         nXIF2qfeU1tY8NVb81VK4K842ttdia22cTtmELWcB62eY0rg/uRl7Vorvctx+pP89Ppn
         PQ0Hpwtz3BBtocMEMAWqF6HTLzTg8yD9Xu/NTZ2iVQtwpcVE00f2Ortvku2aUEJrAzxx
         iz8r7E3w6+swMiwjcxWwUSm9GpxtYUXU1Q5AShT20QR90ejTpsLcg9sO/ejwzjLwYagl
         rccg==
X-Forwarded-Encrypted: i=1; AJvYcCX5AKr2JLHqw0HnPbxNSy35CYDe3NG0AKp7TBqgXyPwSaDQunHa+jIYWMOezXenfioICZnHRlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmZ1ba9CXLS0lqolnslUF8sYxRZJg0jj3DvT54QCdqFVn5/Cta
	pg7MNqpz1KMCT0WfzVTkWdPTGG3dX1e2f5yC0c6tJ2bAB+EQ4GbdXzyvrLWSOscSldrOP+0bqqv
	MyUdqd3NJO3Yfe9vK09bu7tpSELL978ZBCpawvY1M
X-Gm-Gg: AY/fxX566uISiI6elKBKwIAHpjHi9oAemIYvSiaRqGVDDZDm0ThTR86/5VMumCOFal3
	fwjMEwlalwqQ2UGSefjQi38rjfNOjDTCk6HsVgul361dd7pJljrko99KawbWr6jBRhpOlc3PQRn
	CPZ7Y65g9R8zM26mES476I7pO4JNyNu0kGK0B2/oBQh0FJA2cB4n70ubK0QcBnGSJt4NQ0JONWg
	OAJxuvKFKws65EpE7ePWkEZJPueVr8bMcdiyHyVzMybF9uR+nSTh3jjva0EZrBQKdqrKC9PEUdQ
	PZGj8V9R77JhaA8ePs8vqyx0u2PCX1CMrPiUUdQ4bNMoLdLkyOFLib9FQmuX
X-Received: by 2002:a05:622a:1342:b0:4ff:cb75:2a22 with SMTP id
 d75a77b69052e-502b0673b32mr11255181cf.3.1768752659324; Sun, 18 Jan 2026
 08:10:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108155816.36001-1-chia-yu.chang@nokia-bell-labs.com>
 <20260108155816.36001-2-chia-yu.chang@nokia-bell-labs.com> <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
In-Reply-To: <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sun, 18 Jan 2026 11:10:42 -0500
X-Gm-Features: AZwV_QiOr26zAWiUyzYVGxtB4uUNxYcdhHaXiVDyCTcYKsivAZl7luiVeGFtNPs
Message-ID: <CADVnQynBnqkND3nTS==f6MGy_9yUPBFb3RgBPnEuJ446Hkb-7g@mail.gmail.com>
Subject: Re: [PATCH net-next 1/1] selftests/net: Add packetdrill packetdrill cases
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, edumazet@google.com, parav@nvidia.com, 
	linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org, 
	dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 5:46=E2=80=AFPM Neal Cardwell <ncardwell@google.com>=
 wrote:
>
> On Thu, Jan 8, 2026 at 10:58=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.co=
m> wrote:
> >
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > Linux Accurate ECN test sets using ACE counters and AccECN options to
> > cover several scenarios: Connection teardown, different ACK conditions,
> > counter wrapping, SACK space grabbing, fallback schemes, negotiation
> > retransmission/reorder/loss, AccECN option drop/loss, different
> > handshake reflectors, data with marking, and different sysctl values.
> >
> > Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > Co-developed-by: Neal Cardwell <ncardwell@google.com>
> > Signed-off-by: Neal Cardwell <ncardwell@google.com>
> > ---
>
> Chia-Yu, thank you for posting the packetdrill tests.
>
> A couple thoughts:
>
> (1) These tests are using the experimental AccECN packetdrill support
> that is not in mainline packetdrill yet. Can you please share the
> github URL for the version of packetdrill you used? I will work on
> merging the appropriate experimental AccECN packetdrill support into
> the Google packetdrill mainline branch.

An update on the 3 patches at:

https://github.com/google/packetdrill/pull/96

(1) I have merged the following patch into the google packetdrill repo
to facilitate testing of the AccECN patch series:

"net-test: packetdrill: add Accurate ECN (AccECN) option support"
https://github.com/google/packetdrill/pull/96/changes/f6861f888bc7f1e08026d=
e4825519a95504d1047

(2) The following patch I did not yet merge, because it proposes to
add an odd number of u32 fields to tcp_info, so AFAICT leaves a 4-byte
padding hole at the end of tcp_info:

  net-test: packetdrill: Support AccECN counters through tcpi
  https://github.com/google/packetdrill/pull/96/changes/f43649c87a2aa79a33a=
78111d3d7e5f027d13a7f

I think we'll need to tweak the AccECN kernel patch series so that it
does not leave a 4-byte padding hole at the end of tcp_info, then
update this packetdrill patch to match the kernel patch.

Let's come up with another useful u32 field we can add to the tcp_info
struct, so that the kernel patch doesn't add a padding hole at the end
of tcp_info.

One idea would be to add another field to represent newer options and
connection features that are enabled. AFAICT all 8 bits of the
tcpi_options field have been used, so we can't use more bits in that
field. I'd suggest we add a u32 tcpi_more_options field before the
tcpi_received_ce field, so we can encode other useful info, like:

+ 1 bit to indicate whether AccECN was negotiated (this can go in a
separate patch)

+ 1 bit to indicate whether TCP_NODELAY was set (since forgetting to
use TCP_NODELAY is a classic cause of performance problems; again this
can go in a separate patch)

(And there will be future bits of info we want to add...)

Also, regarding the comment in this line:
  __u32   tcpi_received_ce;    /* # of CE marks received */

That comment is ambiguous, since it doesn't indicate whether it's
counting (potentially LRO/GRO) skbs or TCP segments. I would suggest
clarifying that this is counting segments:

__u32   tcpi_received_ce;    /* # of CE marked segments received */

(3) The following patch I did not merge, because I'd like to migrate
to having all packetdrill tests for the Linux kernel reside in one
place, in the Linux kernel source tree (not the Google packetdrill
repo):

  net-test: add TCP Accurate ECN cases
  https://github.com/google/packetdrill/pull/96/changes/fe4c7293ea640a4c811=
78b6c88744d7a5d209fd6

Thanks!
neal

