Return-Path: <netdev+bounces-293783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAAFCv6SHWqScQkAu9opvQ
	(envelope-from <netdev+bounces-293783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 16:11:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8213B62090B
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 16:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5137304DFF3
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 14:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBD537F8DD;
	Mon,  1 Jun 2026 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJggPkCW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXvbrNIC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF7E194C95
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322682; cv=pass; b=Nx7Dc5QTf6sdxJzivnzc3+F4FhxQ9di+otcWvc7scVCUr8fneLX2VVTVzKs1zUGQoVEYYmabPtD3Zg4RoI5S/vgIkwgGwHy0TY+bDM3USeuVn3ILxhIMhXOJTrZdqrT0HbsT1r7qe1yLAtjhz518Ut57mBdrk2ifAeae4XfygUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322682; c=relaxed/simple;
	bh=CFrtvGmfhUK+/WMj5uzU2Dr0YEHsNNcF9nrXsbVp3js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=us5tZvRrK2xiI2Fx0OQsQ06YnsKM3fP+McA2uJ5M0fvcW8UWV0wb2vbjJmPTdqKvOC9KQux/3LM/6y7DkjDLgLJlsZlGFnKJmNRXxdRLO6bkR892QtGCNp+8DVAYuGSWQN2PadDpmHmuL2N4FbXkAV9fwGCHAodbtJQnQaAW4/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TJggPkCW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IXvbrNIC; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780322680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFrtvGmfhUK+/WMj5uzU2Dr0YEHsNNcF9nrXsbVp3js=;
	b=TJggPkCW0AmFyFueGGNWyYCWvD/DpkFhrDfU91znF6TlIR9X6eGQ2jBUbaU8FB0Fvv3sHc
	TXAqF8OUXMrKOUFTZPi+BUHh16J8OZB17DCB4Fn1n7Z0xX5ajO8ahq8vmBex6o33FOY2DP
	2OGcrlr8eL0NT7RpFQDn6ZGOb2rVjp0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-Bmcq2weuMmuTo58DVQ6A3w-1; Mon, 01 Jun 2026 10:02:13 -0400
X-MC-Unique: Bmcq2weuMmuTo58DVQ6A3w-1
X-Mimecast-MFC-AGG-ID: Bmcq2weuMmuTo58DVQ6A3w_1780322532
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5aa68cf0a4bso770654e87.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 07:02:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780322531; cv=none;
        d=google.com; s=arc-20240605;
        b=P7g8lhHwmT0wnNRjWjZUEB2JGTP1ZAOxCRfzX0ivAZKe7zxH5AYGw4hfYXqSt6o15G
         P6/hT9hu+itG/+qR0OfKxssTjY/mApoEIDq7l6UmRkjxH853ao+kvA57U0k5K5Yo+Ho/
         zGxC/fghUPOnvfYuB2kbrPW/VXf0hcim9Bhn5dQXPPXok5Ltu1uVaqDQq3mkpqgVlmGa
         +5/y5i48qE7N0Troh9Lq1WFFhiSeS/TqjEFcz42VBPQR/xynyXLhHbmOZG3VRsSewXCw
         zUknV3g0xAFjW5aLrZ+nv+l4ICPlyplzL1hE+9L3cwQ+w8b382Ja/NB9caqmvzgt6odH
         stzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CFrtvGmfhUK+/WMj5uzU2Dr0YEHsNNcF9nrXsbVp3js=;
        fh=x6IanxjBdrXhgX56brhSs0QtTtG6t7g051SltrsUtuI=;
        b=EW1ideHJrv37ovfZ/DeesaftLJgZl8LyvaR38leBg9CB5v6A1dugzcycJnH9heIKjN
         PFwE51LpTNfWQj+I0uDhzUkfubf1mG8gXnJ4Dl3GIEUBesRm3dkEXS2tza4Ww3SDRRi2
         lB8xnvNrIcXHHxB48dXTq3E814Kirq837Nj57rWWyq/MmGIrQQSEQZ6o3X2u0+/YhKtt
         +R4MYdjYE26spT7G63o0RTbdRRZT8YOLRePzqTfTASmY/iXUsCUA0BBRfsCGBUfulnvz
         Dle1T8EteJxlmzCUVImbhYI9avc8VbUr5y5/AoCwWIB+Irn0V32WtJ7sm86Bo62fKavR
         3ELw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780322531; x=1780927331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFrtvGmfhUK+/WMj5uzU2Dr0YEHsNNcF9nrXsbVp3js=;
        b=IXvbrNICiIbp2Anjla6gK+ifgs6wRBfa0kT2wA2q3gpLAqNU4633PXOHPhtwBqZIZ9
         pSY9gV5eny7qhf46BZHGLfADdIoPDBWPESrMptZOsFCwEhtJ1FfmY4SdYy/6U2YdweDn
         2/VXOHt6EToIxKCoING6ZPfP1+fJ+wfsyjO+gDBheFonggWiMyz/x/F+k3fPD0xFuDTN
         rgqChNOZQnA+JtyOpufnbjHCEya++CClV938JKdyTQNh71lGc3Tm2me+TvPFlrqq1Sz4
         ZD4w2R5ga/JqBXb4X6nM47K0NodeY+r0HytdmGewgOWaTcCrbZOZ7hzJdf3I+SQn6/y8
         8Rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780322531; x=1780927331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CFrtvGmfhUK+/WMj5uzU2Dr0YEHsNNcF9nrXsbVp3js=;
        b=sDkF0v1ZpcBzSben9KJR6AkiwGbDJd3pgwAW8svfbR4NVixMISuXLMeEv1xNgZFw0G
         Dh4WMOokNVNTQpIMfO1wcC1nZNivs9NMkEuys4L8BYloOqb1gPe+w7PVMhGt2UKQexEh
         BVL8jPqtoMegwC1a/mx6xfhzqnPrN+XksBgDLlvyNKPe5mQ4Jo1YUg4fI+k3uoSmWxbm
         9ILx4dE2WEfzvGEuNmO2uC/TYfPGzw/oaUdFq7k0w4/ctPQGlkAPf/PZODYRnqhvdYDg
         gka7MudgomfDG4d5A+Ia9aWYMmYymb7gdP4hK6/JEaEQtRVn/W37LLd+0wggT3/M/M3L
         /KsQ==
X-Forwarded-Encrypted: i=1; AFNElJ9seARLyYk1ClEHLnnHL3A8JvM+XpxrtpZqCTUYP+1XQcF7HIDKzNKJsg2UYbDaHcdXxanfOks=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUoAwH/GQAwcdQIVp9AJMynKKjjTgS5+D04XSzpjTD/DfOcVRQ
	MJmeFlH/PmLl/ONpJexd/KOFS9HLep04NMzrHzdNwCh4IXbV3tYCghiRkceVBR9MYgVUKCfb6AB
	OS/Bs7GOvBtkkg55ZBQY7i2gysaOYuY7hlom0d2K5jdFNlUiJvWWD677ieYZIwn0Qd3taa028I6
	S6L5ykN8ctSu+eSG7bGFA2BIPIRAgNSyGj
X-Gm-Gg: Acq92OE+ol0iusenAY9GbbGSwJYyPQeZmsJMZyIPlbC+AYyMfQ2ZTE/C7he1hL88mYi
	acjP8GpZ0SI06W7bBKyH1dtWhlnnNMrpOmyL+h8+lykOpOs8MXfwm/Jk2JKZjbhjBu+QS1U7cEK
	KVKId6qYW/TpKKZPUw4kORL0inB4gZKEVMxuC/afmiy3IGD10XCTNpyc7XOnlVfbIYtemiXc1lk
	fDO9MotvPlpgRmK
X-Received: by 2002:ac2:4bc1:0:b0:5aa:5a97:2458 with SMTP id 2adb3069b0e04-5aa61425f14mr2415823e87.11.1780322531264;
        Mon, 01 Jun 2026 07:02:11 -0700 (PDT)
X-Received: by 2002:ac2:4bc1:0:b0:5aa:5a97:2458 with SMTP id
 2adb3069b0e04-5aa61425f14mr2415792e87.11.1780322530483; Mon, 01 Jun 2026
 07:02:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529112357.5079-1-fmancera@suse.de> <20260529134045.56330243@elisabeth>
 <5079261a-79e5-421b-bf6a-a511acaaeca4@kernel.org> <20260601153525.546746a8@elisabeth>
In-Reply-To: <20260601153525.546746a8@elisabeth>
From: =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date: Mon, 1 Jun 2026 16:01:56 +0200
X-Gm-Features: AVHnY4JxXS-z4a4yH6TIUqvRMklNXbAPyg_Hp4sLwPZCvCtUY9zhA3JOHulUR4Y
Message-ID: <CACT4oueDv=KRZmJw=1N58EN7eoFz5AqbBBMP8FE4=+rQ99oFEg@mail.gmail.com>
Subject: Re: [PATCH net v2] Revert "ipv6: preserve insertion order for
 same-scope addresses"
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org, 
	yuhuang@redhat.com, justin.iurman@gmail.com, horms@kernel.org, 
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net, 
	idosch@nvidia.com, dsahern@kernel.org, Chris Adams <linux@cmadams.net>, 
	David Gibson <david@gibson.dropbear.id.au>, Beniamino Galvani <bgalvani@redhat.com>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, Andrew Lunn <andrew@lunn.ch>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293783-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[kernel.org,suse.de,vger.kernel.org,redhat.com,gmail.com,google.com,davemloft.net,nvidia.com,cmadams.net,gibson.dropbear.id.au,leemhuis.info,lunn.ch,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ihuguet@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8213B62090B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 1, 2026 at 3:35=E2=80=AFPM Stefano Brivio <sbrivio@redhat.com> =
wrote:
> I was thinking that if we implement a label like NLM_F_INSERT_LAST
> (David's proposal for the name), we could patch iproute2 to set it on
> 'ip address restore' at least, other than using it in pasta(1).

I'm not sure whether what I'm going to say is a good idea, or just a
plain stupid proposal:

By reverting the old odd behaviour, UAPI is restored, yes. On the
other side, userspace programs won't have any incentive to start using
NLM_F_INSERT_LAST, which is actually the most desirable behaviour. The
old odd behaviour is very error prone, as we can see with the `ip addr
restore` bug. That's why programs should adopt the "new" behaviour and
this will save them from introducing bugs like that one in the future.
And new programs should get the normal insertion by default, without
needing to read documentation or kernel headers to find
NLM_F_INSERT_LAST.

What if we reapply the patch and add a NLM_F_INSERT_FIRST /
NLM_F_PREPEND option instead? This will break UAPI, which is bad, but
probably not too bad per the conversations in this and the other
thread. Userspace programs affected by the change, like
NetworkManager, will need to be fixed, either by switching to natural
order insertion, or by passing the NLM_F_INSERT_FIRST flag to restore
the old behaviour.

Additionally, a NLM_F_INSERT_FIRST can be implemented for IPv4 too, at
least for consistency (I don't know whether it may be actually useful
for something, likely yes?).

As I said, this solution would break a few programs like
NetworkManager, but the fix is as easy as `if (ipv6) flags |=3D
NLM_F_INSERT_FIRST`. Would old kernels ignore this unknown flag?
Because, in that case, we don't even need a detection mechanism from
NetworkManager.

>
> But that wouldn't be enough for your case. At the same time always
> adding it for RTM_NEWADDR requests in iproute2 could break somebody
> else's scripts. I guess a reasonable solution could be to add an
> additional parameter for ip-address... 'insert_last'? 'last'?
>
> --
> Stefano
>


--
=C3=8D=C3=B1igo Huguet


