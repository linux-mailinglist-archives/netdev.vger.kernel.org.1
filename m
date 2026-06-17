Return-Path: <netdev+bounces-300158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id exE6LKqOMmpM2AUAu9opvQ
	(envelope-from <netdev+bounces-300158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 14:10:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6366998B7
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 14:10:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fKKasQGQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300158-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300158-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A203D328ECA0
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48413ED5C9;
	Wed, 17 Jun 2026 12:00:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A090231A21
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 12:00:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781697621; cv=pass; b=HUA1LdAc14UNcWxyFDBUBmg1pOLOwmO8KjOruKuUtn6Sv09LQzR7h41Oeoc1mHL8rS1QHIBdZd3AKHZgmQ4CwF2cb+HtXahRoaiSosni8bbX2UUZeeLk9uVEhWm72fgbBLxPaz+WMc5NCiKHrtsN834hItK8HYaMzX3zJ52cEDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781697621; c=relaxed/simple;
	bh=9ymoeEPidKfzkZONuR4B16ek9eOD8FYaVaAsgJjxHfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TjnH2mOaOHidz7luA9n8dpcZX6uQ6oXVOCBKnLAzKFRDXz67cMmpW0y6u7DSM1Wi7+6Pt1n5K56N4Xhss+vsDinaHbO3+DAdsXKjkLrE8zrwSqvObc+zFoOAFYJIoCZrtCxt5LnOWeXptIJar5nQrYiYxt0GZBuS2VAYjVTB2ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKKasQGQ; arc=pass smtp.client-ip=74.125.224.66
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-6608c1a4215so1028613d50.0
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 05:00:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781697618; cv=none;
        d=google.com; s=arc-20240605;
        b=I+XcZ/eScyeJq33L+SLlJAtdrG208Dhjc8mqIEz5i8VkDEGLK0NLAfzUSAhPtga1T1
         fPrmr34f0SslByXU1I9ex8eNT5CsZG0D4yLhsnVEXszFatEBoSM6Ixv8s+DiMKLlf3oW
         M3xcStyXbmSwG73gJvLNjOjVKsanrWY1m2BudUVzmeD4Vgfdf5B+ZGKaUvaX+zpaT/Fu
         OshtM2lVmxRVJKW7hocjEwo6x7MaPjLkNAay8SDxxq384Hkgxniy9wWUW2R5eeYtt0ov
         +yXhOvuQNV9z5ZlcnvI7bTAzAaX0XcemxwnA0KoZcWy39Avg2ZTSj+rKOcfm2YNWp6RM
         1taQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9ymoeEPidKfzkZONuR4B16ek9eOD8FYaVaAsgJjxHfc=;
        fh=RaayaDL+fnZPAqK3iBiWqNarqDRTJQcF9EJf5KNEOG0=;
        b=P0R6GiAsfUXZR6W/QUOAbGHNt5N3H5/AvJ92kkf8+eBrSL2Nz7PHGYul823FBwF36T
         Ar7pvorKncqa/u5QZTLhH44qxqhGhy2gqCsXN7X7h7HMz+S+1sRO8uh4mpXsaB7v1Ca5
         obmBA+BZ8FOLUw+vKtXquuaewzlgsZP5pHSXaMNwCqfBhBCV379SS9jOrho5LrZnh320
         L7rjn6aBP34k1AOQi3LdVre6VRocoFef4H8eYP9K1PwLO1GXcufsshU9X7BBLA8k/ya8
         ZV7T+0ejE2Ve91yWCJ21C9LWcOIjIiz5LDfE9pcCJyuY/LHoGzlFHUUZ8Ftda5lQeRqO
         k+cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781697618; x=1782302418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ymoeEPidKfzkZONuR4B16ek9eOD8FYaVaAsgJjxHfc=;
        b=fKKasQGQAyaUMtkjvtNnqJDg9XHwD33ASWPqISkI9Esv/eA2Gfvz+JNuom6/vOcjRf
         n/NVyDLmeYTL4KS8qJ3lJmUzD3fqbUtWTMdRqxU2WbvFIdo6LDZ+IcpHNcM4eomL9uu0
         8XwgcQVzDij2C5iwve8JJ5h7BAlBkhPDCYohbUo7NHSWxt6bCfIN9+uz+aBTWILmcLYB
         lF5Ebe4G6pvBII6qp+ev8Wq8UKJZZCwwMeoLjvFFUNsD9qRj0PT+ijS83ooEkl3McGSk
         b8rrq0ACFdIXJdGB45s6vnrpJJrjN8bD/lgx5/gQd/t7yogsk4kH/DJ9icypPn8Ib9Wq
         UAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781697618; x=1782302418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9ymoeEPidKfzkZONuR4B16ek9eOD8FYaVaAsgJjxHfc=;
        b=Bt8kMgYmskc86yRqgJ7/wvXTizKlbBtzymfh8tDsVkmYGRkrQFjkhflneK9U6Nc8fH
         DxjwXVNDPWN6w+Zo4cqoJtALhtWiFesl/AlYpoNaGxt7adqhH/nnF9zeervDc9YcGe0I
         hRWjKZcfeiF00hN2UwiaWoz30q7GGkJOUuihcixbq8V53/WfpNuedhm6Wd2dtIZPmxmT
         hhlsDS3bgYlUA5/FF3CSfADhtIYRA/HyXh/m+1BY8vBignRcO8vcxBiqxOzMjLP94fUe
         oyFD4/bE7PlrJttkNxdnhy99jSEjHMCrc+EDJzqioVPEYR6TdCve2iTQvFM4RfTnwKWt
         jQvA==
X-Forwarded-Encrypted: i=1; AFNElJ9wBk9pok4PmiTxpqvsi5p+f3LB360GQmB0nT1ugDxqEFrPIj5ne+Bg7Wbe3xMhjrJq9l+vbOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz2Bu79EOo97jO+ZYSZVnOJlaTIwI4wquEKGTrG5u+VGc6wee3
	JuvZO8wocCNA3nrBzYZltvBX8Dkpuojong+hh85KN/1r6gABbF70YHKSV2ECY0AeJOKtiKu6HBN
	KwocObBCRBikIu6TQ2xFDhum3fC79UMA=
X-Gm-Gg: AfdE7cknfdvy+34gzE9AZkIiKicnim4TnTun4x/1Cp5bgaC33sozDrZMECIQ85YYNce
	QCP+76hqGTd8i5xQdppEQ7w16p5/hOgiDKmm6vtsOMfiTg8G6FNzpnZVMSCLgfnJz0fKsXpOR8K
	2RmYeGuM7NOh5flU7+L0M+6gdcIElUn+hw6hz9kC40sDvJDW3ATSVUDD5nGPaDiTKIY0tJ2NcyQ
	+MnI6W62U6biVLyDvQ7+TEQm5MRMrh6z4e7CS5yS11LPeOb5cIDyZHObW9eNqSZESgbx8Qd0UA=
X-Received: by 2002:a05:690e:1306:b0:654:3fca:3515 with SMTP id
 956f58d0204a3-662ced30a5dmr1739473d50.30.1781697617856; Wed, 17 Jun 2026
 05:00:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
 <20260611071242.2485058-2-dongml2@chinatelecom.cn> <20260613112113.55d9313f@kernel.org>
 <TYn10tJ2SIGF1pAhF26DRQ@linux.dev> <ajJrckiXEUztBQDz@boxer>
In-Reply-To: <ajJrckiXEUztBQDz@boxer>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 17 Jun 2026 20:00:06 +0800
X-Gm-Features: AVVi8CceZgHFM8mfvFHKtEXFCMHWNlKB0MljWDwvRAc_BYBHABk8LGbFC_ALR_Q
Message-ID: <CADxym3aXnGwna-TKQmJ24UD1XNmq3hsapRQXQtwKF=YC-qqrOA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: busy-poll: introduce sk_tx_busy_loop()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Menglong Dong <menglong.dong@linux.dev>, Jakub Kicinski <kuba@kernel.org>, jasowang@redhat.com, 
	mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, magnus.karlsson@intel.com, sdf@fomichev.me, 
	horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bjorn@kernel.org, kerneljasonxing@gmail.com, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:menglong.dong@linux.dev,m:kuba@kernel.org,m:jasowang@redhat.com,m:mst@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:magnus.karlsson@intel.com,m:sdf@fomichev.me,m:horms@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:bjorn@kernel.org,m:kerneljasonxing@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300158-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,intel.com,fomichev.me,iogearbox.net,gmail.com,vger.kernel.org,lists.linux.dev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F6366998B7

On Wed, Jun 17, 2026 at 5:40=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Sun, Jun 14, 2026 at 06:12:46PM +0800, Menglong Dong wrote:
> > On 2026/6/14 02:21, Jakub Kicinski wrote:
> > > On Thu, 11 Jun 2026 15:12:40 +0800 menglong8.dong@gmail.com wrote:
[...]
> >
> > I'm not sure if it is a good idea to introduce the sk_tx_busy_loop().
> > Maybe we can modify the driver instead by using the same NAPI
> > for both data sending and receiving, just like others do. The
> > advantage of introduce sk_tx_busy_loop() is that we can split the
> > data sending and receiving, which maybe more efficient.
>
> Would be good if you back your changes by any performance numbers. I
> believe that drivers do tx processing via rx napi as before AF_XDP it was
> only about cleaning up writebacks, AF_XDP added more weight via actual tx
> descriptors submission.
>
> Maybe you can vibe-code virtio-net to work only with rx napi and see what
> are the results.

Hi, Maciej. I have not done such performance testing yet. It's a good
and interesting
idea to do such testing on viriot-net, and I'll do it. If there is no obvio=
us
performance differences, I'll modify virtio-net by sending data via rx napi
instead.

>
> Side note/question - Do you have a tx-only use case for AF_XDP ? I am
> planning (for a long time actually) to implement asymmetric AF_XDP
> sockets. Currently for ZC scenarios xsk socket occupies both rx and tx
> queues even when you do rx or tx only.

I think this is an interesting idea, and will be helpful in some cases.
I'm improving the performance of MySQL with AF_XDP. For this case,
tx-only is not suitable, as data reading and writing are both needed.

But for the other case, such as Redis, data reading is mostly. And in
this case, I think it's a good idea to use such "tx-only" ZC AF_XDP.

In my case, I don't want to occupy the whole NIC or the whole queue
with AF_XDP, and the other users can use the NIC too. However, the
ZC of AF_XDP has a little additional overhead to the skb in rx path,
as there is an extra data copy.

If such "tx-only" ZC is supported, the performance of AF_XDP is still
good in the read mostly case, and doesn't have additional overhead to
others too.

I haven't used AF_XDP for such a "reading mostly" case yet, so I'm not
sure if I'm right ;)

Thanks!
Menglong Dong

>
> >
> > >
> > > Third, this series does not apply.
> >
> > Ah, I'll rebase this series if a V2 is acceptable.
> >
> > Thanks!
> > Menglong Dong
> >
> > >
> > >
> >
> >
> >
> >

