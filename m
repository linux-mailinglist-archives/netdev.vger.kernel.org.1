Return-Path: <netdev+bounces-277089-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEVVCBTm12n8UQgAu9opvQ
	(envelope-from <netdev+bounces-277089-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 19:47:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DAF3CE44E
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 19:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F37F3011BC1
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 17:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2594334753A;
	Thu,  9 Apr 2026 17:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QQ/CBWLs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74932417D1
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 17:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775756816; cv=pass; b=eNp3pyBJ7WHF34TzwncioB2dbdtQCb6FwBGHvPMnyhMjxsa2Yvrmb4dUN9PuSAoxDSyE/BvXmT+TO7luSdIvAQQfTuMkSf1P5Qb0s6V350kxZ2v6S16VAiK5VsMjXLWNUI+xCInEY/qE4v8R3UPguhx5ECeK/4CMl7utGUE0nWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775756816; c=relaxed/simple;
	bh=bNxbkmehiO10b5i1ezAZgDe15UroUE3Wic55cDdszxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAnHe6qEX2KN9feZVUkEk5UI91hI4sJvWFrxkZUMq1icQ1R0jVSnqhuFCtLmquVHWxMRtUELzQGAB2GLACiIcJUXrWgCOF9EDvmNV2NCPgXkWk4xQ9LQxFdTcM6ZLiu+EVaKPj/SZtvaGcFwTpxYcGQo6jTzQBvG3dwSt8QeveI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QQ/CBWLs; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-60579b9c0ccso891260137.3
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 10:46:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775756813; cv=none;
        d=google.com; s=arc-20240605;
        b=dQuXnc8sUtaEk1zhrvkzDvFzRwo8WBMB3QRMhq4czRLJKL8UBhW7JOW+cYOss3D52e
         aOSnlbY/LzfvQDEI35f9RJrKODHdRoHa+hVgyBeIfnQJBGv2PoP4iZwiImVjCwJCm/KE
         HlDNTF5FoHEWARyKQ4XF+fE/d3USc2c29PSZjR5nxR8w+kN743wWJxIwfdWlWir6x9tH
         YpLKDLnqLmEWvNLNc003YXI1yiJO7fCK0B5dmu/FHIfY8ABheZT2v6hVa2KL3qtWar06
         LB1Hlex312zanWuT4coxOAadwDlnQ6MT5tOPO8yBvi0PtbwJv7QCnAQc31nuEtJ8dIfH
         7CVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bNxbkmehiO10b5i1ezAZgDe15UroUE3Wic55cDdszxU=;
        fh=AncD0AS9UsLKDFSJyg9EIrmTarBUaKA1UHVIu3FeFWo=;
        b=L9ETpCLM0o9QVgG+PoH3WvsbWAW41yz/nEUklL4lYn76mY0bBK12KggSoxsyQ/394O
         skMeRr5hmfGAGbhTMXda+h2p5Ob6ofFpvII0oHn19TLL/bZHWlSc9CT2LMdQq8/XFnVX
         V2RQTy6V2NctS1SEgn6enhUCcjO/tsbmrLv/GWKuvAzoPzhepZVfUAoVMXsZM3dzbTzi
         X2vMo3pragAJg++9eeiVEHSTwiEyM1uD7fY9Ly1HEYViD14948swVRPX11cz4OWMzzw2
         /bs6nNU8MzAHEmhzkBnWt16909kISLASoW0udEO9+kngY8lwkBxy9Dn9NYV5uql4ViYo
         RqSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775756813; x=1776361613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNxbkmehiO10b5i1ezAZgDe15UroUE3Wic55cDdszxU=;
        b=QQ/CBWLsQyyQWKMJaN67IstePXsf7JS1g0rx/RsA/L1YwyYBRamQhsUIDq7Z9wpo+a
         /TTbcLCGNULAgB8qES37Ls9MjHq1Tk2kzJu7O5VdfxOuUquv2hL3jThEdn0/mKPuYPgL
         4JfbKBJEHiMITl2DfcGQ65B+1OK1Bu3KB04G9C65El8PAe01XkM/E+L39qUuw+0rs36x
         6TrXA+QKKwmfC885Ueb/9FW/Zs9tjvwzO8SaKx2H3D8r4mAEPulz4PiONj9gG217r+gc
         7pmpN/9L9Hn7qDZZ4zCn8jp2igqj8snGmwQJva6oH+1AjoctSOod+Km7P/Tq0+dm65ZM
         bULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775756813; x=1776361613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bNxbkmehiO10b5i1ezAZgDe15UroUE3Wic55cDdszxU=;
        b=HhBeBh0Ea271xtcxlu4NplYgpEqeAJu7rYFDKKQ467FfKtbdbQ6z1qgCAGaSXd3/jz
         eC/MZfrD4Rh5a9s5/gOZGXa8MKEY7Ecf4B3KiAhwTY6mSxKUFHMSeTYKCGSpuAi+fUye
         GW5d9HyHK2BuZ3EiCAK9WZo6NoQQIG+WxFZU7LtJohH35xyRXxOOcj++PjCxVysym0pp
         72JD8AkTmxyjWfESLsoMhSNWLMB/n7AmWXVnqFQdm2uDBw4DVJtiEWk3GzTwpA14qvBJ
         4Ko1jpUc4YoodNvKdHB0qdRQX4McX3X4CqRbEtqERjUpy5X1LlHwouJ/GTAdevGsNiWB
         78Fg==
X-Gm-Message-State: AOJu0YzdX2WkuzEZQzEUXWRtRQUhb3BohHNOXkonO25itoF1AcnQezzg
	bGfVcGvEkhoU7NK/C2N1aZ0GaxXz/UWQr4474enALwe+ccABr3/q6m3s/SFOfi2Btc/LtttgnBv
	FSLwM1Yx3WXjZwuIudu8WjHRL6eCzKe9CAyCz+oz1Ew==
X-Gm-Gg: AeBDietwSFmqllJotlGL00PxsV4QgrfdU52cWfUNInOJMn8RsMlg+KUelPk24KuaACA
	t8NXPsac3sup0qjHd6KY/I9HhIy66o4uCM1BSjZ2yoRUPoXmrOjj1uhKsg2DjHF7PBhd6Az5z7z
	ViIKfZfevcdKWVArNkEvPrHy5r5sX+2iHCq+prK2v16FJuLRLJ4fiElvnTO5DwGffyz5mCZg/xa
	4ji6nTbhrs+HRAykDYr7oxZt4ncJecRXTD92won7Fp8QEojDlPq6IOMDkFpVDQBZh8ksYcUfQZ+
	sx9OpmNxf8ko0aKkcg4=
X-Received: by 2002:a05:6102:c4b:b0:602:7470:2428 with SMTP id
 ada2fe7eead31-605a4d69432mr12306785137.10.1775756813471; Thu, 09 Apr 2026
 10:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402235511.664801-1-rjethwani@purestorage.com>
 <20260402235511.664801-6-rjethwani@purestorage.com> <adQeoGH8qmhhCSal@krikkit>
In-Reply-To: <adQeoGH8qmhhCSal@krikkit>
From: Rishikesh Jethwani <rjethwani@purestorage.com>
Date: Thu, 9 Apr 2026 10:46:40 -0700
X-Gm-Features: AQROBzCN6UknnnQud_huE9C4C14de_U9Who3eX5c5ws_U5naDQQ-adgn_5JCt9g
Message-ID: <CAKaoeS3pNe-DH2vA1E7t9NOn3H_ZUGk+cM0LgoYogkWEU0aqLQ@mail.gmail.com>
Subject: Re: [PATCH v12 5/6] tls: add hardware offload key update support
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com, 
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	leon@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277089-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,kernel.org,davemloft.net,redhat.com,google.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[purestorage.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 72DAF3CE44E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 6, 2026 at 1:59=E2=80=AFPM Sabrina Dubroca <sd@queasysnail.net>=
 wrote:
>
> 2026-04-02, 17:55:10 -0600, Rishikesh Jethwani wrote:
> > During a TLS 1.3 KeyUpdate the NIC key cannot be replaced immediately
> > if previously encrypted HW records are awaiting ACK. start_rekey sets
> > up a temporary SW context with the new key and redirects sendmsg throug=
h
> > tls_sw_sendmsg_locked. When no records are pending, complete_rekey runs
> > inline during setsockopt. Otherwise, clean_acked sets REKEY_READY once
> > all old-key records are ACKed, and the next sendmsg calls complete_reke=
y.
> > complete_rekey flushes remaining SW records, reinstalls HW offload at
> > the current write_seq, and frees the temporary context.
> >
> > If another KeyUpdate arrives while a rekey is already pending,
> > start_rekey just re-keys the existing SW AEAD in place.
> >
> > If complete_rekey fails (tls_dev_add or crypto_aead_setkey),
> > we stay in SW mode (REKEY_FAILED) until a subsequent rekey
> > succeeds, while maintaining TLS_HW configuration.
> >
> > Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with multiple
> > TLS 1.3 key update cycles.
>
> Something here doesn't seem to work. I have a very simple
> client/server pair where one side just loops doing large send()s and
> does a rekey (send keyupdate + change key) every N iterations (I've
> set N large enough that it goes about 5 seconds between rekeys), and
> the other receives all the data and changes its RX key when it sees a
> keyupdate. If both sides are doing SW, it works. If I configure either
> side to use offload, decrypt fails after the rekey unless I add a
> small sleep() just after changing keys on the TX side.
>

Found 2 issues with this test case:

TX HW Rekey: The start_rekey function is missing the EOR (End of
Record) marker. Fix will be included in the next code submission.

RX HW Rekey: When the receiver tries to rekey, multiple new records
are already decrypted by the NIC with old key and present in receive
queue. To handle these records, we need to store the old key to
encrypt with the old key and decrypt with the new key. Also, we need
to consider back-to-back rekeys if we store the old key.

Any suggestions on how to address this?

