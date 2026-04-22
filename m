Return-Path: <netdev+bounces-280457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMF0IvTr6Gl4RgIAu9opvQ
	(envelope-from <netdev+bounces-280457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 17:40:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9956448044
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 17:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4EB03056155
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 15:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52CB346AF8;
	Wed, 22 Apr 2026 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QT3E+80I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F131DF248
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776872216; cv=none; b=kxlorMfzc7a+jNJVV11SrJV/PBp6LPg1ePHTrwQKn3aRJ3pqei8LBTMsKEG900Jmdmf8bePtL4gHMHbpOY3xoVVg/k5dhfEhdLn+sA3MEpxnbLCKLNzCJxkjJZsej4j1rrR1wNs44sj4KFnJYfMrWitD1rlaEaRRlxCkF+WpksI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776872216; c=relaxed/simple;
	bh=I4Jmwzz1ODBCvCGD3inyJttCoNK7K9OZ/Wca1zGloR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sol1qtx0hPI7ECt9IJ4UzHMS/7on0TxElAkDsVgOnlTfSjCWtJi7FlN8PoFQ1qD7jRYQfOBemJ/hjl75lwOsQDmm+fQJF1CEqar3He3+33kDFoAJWOgOgIDx4IlFihWXJEkxrEpvcWnKYzOPza3HMnNgBYx7jSgqyvWdJXnecs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QT3E+80I; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b9358dd7f79so987189766b.1
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 08:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1776872213; x=1777477013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+DwNRPBKYrcNA3RvMgBSsOLry+hrRQ+hSlc37tD2IM=;
        b=QT3E+80IWCDmcPyrWXy0Fn3L7dsT6+3G896rsCyUtwzLBWE1oKlOWEfsLnExPJ69v8
         4Ehcoa6PtTHHs2jw/+nl8PTimwN3OSlD0IdySkBbRgAcSP3WxC0fR3AaBMiR16bdrSrA
         zzbMtGxqulWXcRIkBkGMvgfdq7vq/MsX+3xD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776872213; x=1777477013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6+DwNRPBKYrcNA3RvMgBSsOLry+hrRQ+hSlc37tD2IM=;
        b=DWgUP4VKy1xn7kPAxWyKNB1jtVs8JbeTDvRmdtX4vu8XJ/cehutt4SqWCUN9V48o+Z
         z727sxKf6pt40jLt9PMX7QW3hnQ074/67722RcMk4MpMS00DWFprMzJoYSEgx7RS6MqY
         Q0U3hpFgK4Msi/ORuKXXK7c2rOKQSmdFxxbo3s6pIWN6wXS5svd3LIL4F3XzqkH71wV5
         ctIlzEXNH1Xw/S+rhZhs2tuR7D2e3IwZRCYTKEIu11YRM6z1UV9RY+kCl+qB3mVisVya
         s10BkA8Ca3lS90XPuQdxCm4wYMRKE8Bi+dRLcHbBrW8GqJTXvBuehBuHOd7AF2yHMqKr
         WixA==
X-Forwarded-Encrypted: i=1; AFNElJ9bbWCCXJvwe4CVE7WRPdihQpOO0ViuYwFJ72JwvYNvSi78G0IqdZXhQ1AXi+VsOICxiRpOaBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+AtkaOg2JgIFqHdQHUEJrHUoVkkrZ9iA+nN2p4LS3zDqa0hca
	og8vn8d9Ue6YmP34KLE0tOjrhGiH2Ws22aZnwI4hkH7O5lY6wd4C6KkSLyekJtGV93zPoLG6rzP
	p5CQbtT0=
X-Gm-Gg: AeBDiet9JEKnwfyK2f3AQsph/quV2789/POzyW7rea1sBFYbs8/jRMIjXFOswSPNNXv
	ESf+Lw+B6VogJBO7JwAc0lOqeiiFRe87DssLfuQImPiwTFu0ZcjTGTr6DYh1VZGaIS8sJui34h6
	SCuNv+gNcAUZZD5/1uwFk5bla3/DIvbOfmK69nwwJ5uweSNDJYwUQSRd1Q2Le+kJJFzRxJmYfMu
	JH9kdcNq4APxgGLL190O+9Uc8olvXdJJgIX9zGc+AUf69Rtx6U5kbjAXmyh2PXjBlQPeeUxOMMO
	11XxIBshvaVrmqJ9CU77vH3KOTmrbHqNr1PeeIwv69z9nH93QFoX9+tHG7FHlzv/kTnJjTDVxHP
	ofiRhqzoHuTYLqqtnvr1icv5RqukpqFzRCtA3THfAb9k6voYL0Fh/ZUPE/I/HA2C8j3JZLKH9zl
	8C0l+WSHGI0Y07pZXUnKdg5h8ucIdtQBVQFlXhKJ2zEjT/UFk1KUYCsTbclCVP7HB2vyvaOWDQQ
	ZzL9T859mAWwu/WZXi9ig==
X-Received: by 2002:a17:907:6188:b0:b9d:2fce:308b with SMTP id a640c23a62f3a-ba41afe9d42mr741571966b.30.1776872213277;
        Wed, 22 Apr 2026 08:36:53 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba454d1bab1sm548624166b.35.2026.04.22.08.36.51
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 08:36:51 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ba922426c5cso506945166b.3
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 08:36:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8azJLID77YH452GMry1FiQ+7qlphUj6PDsvwn4ZdPKW4WWOq32zgguPiGvcZOlFOW/mFB23O8=@vger.kernel.org
X-Received: by 2002:a17:907:a646:b0:ba9:3f1a:8735 with SMTP id
 a640c23a62f3a-ba93f1a878amr484489766b.33.1776872209534; Wed, 22 Apr 2026
 08:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419192018.3046449-1-metze@samba.org> <aehrPuY60VMcYGU8@infradead.org>
 <9cb0901c-18c5-4858-941c-3b37ee112af9@samba.org> <CAH2r5msb3-HiPSv+HgBknEwDXGsv0xU=TGCxHdmc-VCLKzYCmw@mail.gmail.com>
In-Reply-To: <CAH2r5msb3-HiPSv+HgBknEwDXGsv0xU=TGCxHdmc-VCLKzYCmw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 Apr 2026 08:36:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=whHACPH7vBLo8CVSqR5-mgzP4ff7qJU6F=1exKTpQ0-7g@mail.gmail.com>
X-Gm-Features: AQROBzAXxjIZr7XwIp1v_ivj2KCglqqVek-fwbJ8jkNR7q5nEXQKW0WRvzxwAW8
Message-ID: <CAHk-=whHACPH7vBLo8CVSqR5-mgzP4ff7qJU6F=1exKTpQ0-7g@mail.gmail.com>
Subject: Re: [PATCH] smb: smbdirect: move fs/smb/common/smbdirect/ to fs/smb/smbdirect/
To: Steve French <smfrench@gmail.com>
Cc: Stefan Metzmacher <metze@samba.org>, Christoph Hellwig <hch@infradead.org>, linux-cifs@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	samba-technical@lists.samba.org, Tom Talpey <tom@talpey.com>, 
	Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280457-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,samba.org:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9956448044
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 22 Apr 2026 at 07:49, Steve French <smfrench@gmail.com> wrote:
>
> On Wed, Apr 22, 2026 at 3:16=E2=80=AFAM Stefan Metzmacher <metze@samba.or=
g> wrote:
> > >
> > > Why is this not in net/smbdirect/ or driver/infiniband/ulp/smdirect?
> >
> > Yes, I also thought about net/smbdirect.
>
> I would prefer to leave it in fs/smb for the time being, since it makes i=
t
> easier to track since fs/smb/server and fs/smb/client have dependencies
> on it.   In the long run, I don't mind moving it, if it starts being
> used outside of smb client and server.

I personally have no hugely strong opinions, but I think Christophs
very question that gives two different alternative locations argues
for just leaving it in fs/smb/

That driver/infiniband/ulp/smdirect location in particular is just a
disgusting path.

It sure as hell is *not* a driver, it just uses the rdma infrastructure.

If rdma were to eventually itself split itself up into the driver code
and non-driver code (like networking does), that might change things,
but that's not happening now.

And as long as we expect smbdirect code to go through the smb
maintainer, I'd rather have the location be about that clear situation
rather than some arbitrary "it uses the rdma code" or "it's
networking".

Because that code is not primarily about networking or about rdma.
That code is primarily about smb.

So while I have no *strong* opinions and can deal with whatever
maintainers find convenient, I think fs/smb/smbdirect is at least
currently the sane location.

          Linus

