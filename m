Return-Path: <netdev+bounces-176543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8120FA6ABBD
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 18:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274423AB2AF
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 17:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4001EC006;
	Thu, 20 Mar 2025 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="PZuwdWMD"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9AC1C5D61;
	Thu, 20 Mar 2025 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742490759; cv=pass; b=ro1c42YMPTBzFFgLiKI/k91bwdUgwyQMArsuD6rBEoH1pjS3KCa7WYO3ZktQodTwc2xP3QLnAlu/78IznYg66P7cOhkWHajNDpQDqg9+snhDsmdpgeV9Q5vP7nHIfLEPWL4YvuSxq9KUvWDvASqIX/rq/bqtACXgx+rxP4rxNy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742490759; c=relaxed/simple;
	bh=qtH4tZDc89DL8XbhSYs5C9MNzWs5Xsmg7tJr62tHPqs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JFkEJn2z67cPGKFtee99wQXNdMYPuDv6naaJkgZFHxQTVDEc7gCfchtE3UmGjjC/tbj/GUpBz6K929/XQI+a1eLTpZ6sQd6Gz4ujtHvjFi8BFz9Uj0tazOdNub6TH3/Lb9ZL5lfs01ocSUqLCGkmPUbD/co6mlk3q2OIO8Y0EUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=PZuwdWMD; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZJXFX3ymMz49Q4b;
	Thu, 20 Mar 2025 19:12:32 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1742490753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k7jXuRYl0NEOtVGNzO8Be5Rxnp9fNqKXCpG5/JQQv0g=;
	b=PZuwdWMD2OWXYd+gMUzBHdGHxsqUHpgxs1imf6f4VjxNC7kjrqu61alw+NN5DS/pbEuTDs
	wQsPSpA+OeeF41tYWF6GM7LFnCyJqeBy7vkEL2y7jpEtnj0PRkLvZB9TxxPfd4xVlOFqID
	PADSkm6yR2rFaQ4JRrCv+oh29aBcTj4rl0Qtle3wUYhqfntr1hr6UtYT5gnxVaDJqWu82G
	VQNjdLf9I79uQILzTeDnazLfFuR7KFX2HGjyV8+FKujRJvqZvGOCew+7d9KoXrclgiijVx
	SbtP/vPiIQWW/E/hF/YvaO6HOuH/t2V8mF0y0YWUuImJpXrYoYFwtwFiynu/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1742490753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k7jXuRYl0NEOtVGNzO8Be5Rxnp9fNqKXCpG5/JQQv0g=;
	b=m3rEqL3GOlZWzXpcJ0jAJpJ3v1z7taYc3AWRfevh1G5X095rEc7oBXd9N/CmFnlhzGSSG9
	hJFgC/lGRlrzwnH7Lb5V6D8S734O0N0M3oyTnx0IMCulbtFaN3pkSB/Ckr3fRim3ZTZVgy
	blX7go2FPLFyv/513DfG2A65AnRgkKJ65JSd+MZSdX6Y8nGuWeITy3TUhKKdoLXAoeowMY
	rTr4Sp13fqveVpx6ZdnlIMcxrv6gIv0qM5oqD7y+hoVT3nRd5puNjTF+ydBmrt+FGaUzgz
	umd3UkjeD/kNsLcZvuQK3pt/vUzWUZO6ig4NofQ9hXKtxeTQMrqPp2G80YxgAg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1742490753; a=rsa-sha256;
	cv=none;
	b=e//hL59DwcOfc6za4Wk7CGiY7U7vqPdu1lW6My8Z3UKvm2b5ghmed7hhKicwzCI+jJe9Ar
	cfwQDqmcoznW7bXlENm5jjz3lpuMOPOfq0VztXxAdYk4mZ6rUDg2J0bCPlCDG5vp3WV9L2
	5q9VJLo1XnptqyZseAH/uHzXTP4XUTN1ICYOUx/uWIpUx7nY6/nc6XtYS2lYKBa9laL63D
	pwiTEYxDFo/uxLoVLEPO2TAv86fow0e5be8/Vw81OIa1sPkdI11rWSstod9yfrz0DFts4p
	Uo1eMyUFqc/fONprSzM8KpCceCce5H9DaXolrI5WR/3cq7RzgBNKBsXBNBcjrg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <12a5ae18f714372681c58247af66b9535a3b4cd6.camel@iki.fi>
Subject: Re: [PATCH v5 1/5] net-timestamp: COMPLETION timestamp on packet tx
 completion
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Paul Menzel
	 <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, willemdebruijn.kernel@gmail.com
Date: Thu, 20 Mar 2025 19:12:31 +0200
In-Reply-To: <CABBYNZJk2QjUaJCurAocMAJdOTfFHCjKO_S2rcxWLwTv8K9VDw@mail.gmail.com>
References: <cover.1742324341.git.pav@iki.fi>
	 <0dfb22ec3c9d9ed796ba8edc919a690ca2fb1fdd.1742324341.git.pav@iki.fi>
	 <6cf69a7e-da5d-49da-ab05-4523f2914254@molgen.mpg.de>
	 <CABBYNZJk2QjUaJCurAocMAJdOTfFHCjKO_S2rcxWLwTv8K9VDw@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

to, 2025-03-20 kello 10:43 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli, Willem, Jason,
>=20
> On Wed, Mar 19, 2025 at 11:48=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.=
de> wrote:
> >=20
> > Dear Pauli,
> >=20
> >=20
> > Thank you for your patch. Two minor comments, should you resend.
> >=20
> > You could make the summary/title a statement:
> >=20
> > Add COMPLETION timestamp on packet tx completion
> >=20
> > Am 18.03.25 um 20:06 schrieb Pauli Virtanen:
> > > Add SOF_TIMESTAMPING_TX_COMPLETION, for requesting a software timesta=
mp
> > > when hardware reports a packet completed.
> > >=20
> > > Completion tstamp is useful for Bluetooth, as hardware timestamps do =
not
> > > exist in the HCI specification except for ISO packets, and the hardwa=
re
> > > has a queue where packets may wait.  In this case the software SND
> > > timestamp only reflects the kernel-side part of the total latency
> > > (usually small) and queue length (usually 0 unless HW buffers
> > > congested), whereas the completion report time is more informative of
> > > the true latency.
> > >=20
> > > It may also be useful in other cases where HW TX timestamps cannot be
> > > obtained and user wants to estimate an upper bound to when the TX
> > > probably happened.
> > >=20
> > > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > > ---
> > >=20
> > > Notes:
> > >      v5:
> > >      - back to decoupled COMPLETION & SND, like in v3
> > >      - BPF reporting not implemented here
> > >=20
> > >   Documentation/networking/timestamping.rst | 8 ++++++++
> > >   include/linux/skbuff.h                    | 7 ++++---
> > >   include/uapi/linux/errqueue.h             | 1 +
> > >   include/uapi/linux/net_tstamp.h           | 6 ++++--
> > >   net/core/skbuff.c                         | 2 ++
> > >   net/ethtool/common.c                      | 1 +
> > >   net/socket.c                              | 3 +++
> > >   7 files changed, 23 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/Documentation/networking/timestamping.rst b/Documentatio=
n/networking/timestamping.rst
> > > index 61ef9da10e28..b8fef8101176 100644
> > > --- a/Documentation/networking/timestamping.rst
> > > +++ b/Documentation/networking/timestamping.rst
> > > @@ -140,6 +140,14 @@ SOF_TIMESTAMPING_TX_ACK:
> > >     cumulative acknowledgment. The mechanism ignores SACK and FACK.
> > >     This flag can be enabled via both socket options and control mess=
ages.
> > >=20
> > > +SOF_TIMESTAMPING_TX_COMPLETION:
> > > +  Request tx timestamps on packet tx completion.  The completion
> > > +  timestamp is generated by the kernel when it receives packet a
> > > +  completion report from the hardware. Hardware may report multiple
> >=20
> > =E2=80=A6 receives packate a completion =E2=80=A6 sounds strange to me,=
 but I am a
> > non-native speaker.
> >=20
> > [=E2=80=A6]
> >=20
> >=20
> > Kind regards,
> >=20
> > Paul
>=20
> Is v5 considered good enough to be merged into bluetooth-next and can
> this be send to in this merge window or you think it is best to leave
> for the next? In my opinion it could go in so we use the RC period to
> stabilize it.

From my side v5 should be good enough, if we want it now.

The remaining things were:

- Typo in documentation

- Better tx_queue implementation: probably not highly important for
  these use cases, as queues are likely just a few packets so there
  will be only that amount of non-timestamped skbs cloned.

  In future, we might consider emitting SCM_TSTAMP_ACK timestamps=C2=A0
  eg. for L2CAP LE credit-based flow control, and there this would
  matter more as you'd need to hang on to the packets for a longer
  time.

- I'd leave handling of unsupported sockcm fields as it is in
  v5, as BT sockets have also previously just silently ignored
  them so no change in behavior here.

- BPF: separate patch series, also need the tests for that

--=20
Pauli Virtanen

