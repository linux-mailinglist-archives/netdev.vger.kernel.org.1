Return-Path: <netdev+bounces-241398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A79C835EA
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 06:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66A304E24DC
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 05:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB94322068D;
	Tue, 25 Nov 2025 05:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPjMQXsw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21461FF7D7
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 05:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764046852; cv=none; b=mx2H9fGLD2pXtoM5dutCwpX/aUVCMSe2TKYZcsyVFVlB0I0XyT56TRz/H91T/9r7UkMXMrTWfj7kRzG+DfLcqqt3VNi0Y76hTZi0OS0ZJGSIu6ld2LHO8qPxvwK8jFCW0E0XKDjp6LeMFUOaKSaGD33WwaamtCaXy3bu2v+s1Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764046852; c=relaxed/simple;
	bh=UUrSmgHt6QsHAb4josEXRjRvT7n3oY+lZntIv7c98+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/BnvHoKnrCAdTEBXwakTSvnUR7P1iPnBQslkTuHJF5nDK+dCmLWF2mn/NdpGmeEwR1aUraZjzN8fbnVUSWfrkavTgN5gdDuQvUWbCQ4gA3ry0q+4eVoEzbiDusioitxojYpNJ1JXXXbcpNLP6sN+WC4y2slaSnSA/AzLfIqXLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPjMQXsw; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b73875aa527so807226366b.3
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 21:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764046849; x=1764651649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgkEIaYmSIgN/j0r5dDRltCfW2UohQiH4qvD0keignk=;
        b=OPjMQXswoZbJFfOhT5wmSa/EAwUSos4nBtaJ8ltMCozgii3a6YWcDsDsAwwF0FYchs
         0/QF4807TvSDonVNncYnbMpD/lkSXHgO8I/OuFM5VyOeLk9UIRS6ZYrMWR5E7x1CLJpe
         z+a+d7PIsjVdL/8kH1xgo93vw0hoSnpWm1+fb8cxO0eGeaTwQUY9Iyoeo5QeFq0oO9lV
         aJfZE1i1HEVcnjcOALizQXXINMxbQeCH6bkOUEk6fw5bsH9TZA4LWOkQitc323da0p6k
         rYH/QXSEWsRDj0QCXdpf2VVGojrpbPmVJFw5B8WWkPMZdFIUKqJrrClEhbcxRrgEEnQ7
         WWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764046849; x=1764651649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RgkEIaYmSIgN/j0r5dDRltCfW2UohQiH4qvD0keignk=;
        b=XSVkn/iFP8C2TEs3YjrHgiVbWvhy0kxB97N4FYIJM3PJ9jfPldjs+vjbVXWFb9gIuV
         x6BeK2unPnqUSVYQXSKYi72MfTYgPrOxAatClHQPTj+cGrkvsl7yKpwZpixlxBhvLb/l
         /FTcu60jwwHnCeR3jypkSqbrMiGp6DR2SFqhhsiNWXDiY7ufIysrIGCt39z5ZsycV+MM
         S/d6Tnh8W18YNS0rJfPYLybItZW/dUwpU6qzVOSv23cIcUm6y9fi4EPDaZZq+XFkVlQ1
         7yELK8ImXQZ9iytcLIWY2BUTlqfWc5+pD7qIALZaRgX5f6Lm1MKpNalf26LRJKhScH0q
         Wi7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVx3EZYr2CSmmhaxsAz3WJDeUKzWbkVfekK1VGa+FAn5wlPMqbPUsN/yXPu7Osvu7gftff76w8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkne+OX5OLVSzwUkFXEImjY8YQ/plE/kYYjQoLWLJF013ROlk/
	3nCTI9kWKsruQ6GsfsJEvuKMOmtAfbaq+ttoT6U9Y9IOKn8FOjvHFFoFvtVPbW+tSokFBF1pYNV
	9YvFd1iGidiHpEopyXjVpPKIrHf1Jj8A=
X-Gm-Gg: ASbGncs00xSoCeFY7250HtbeqcUXKMh08KB0M2nBRbxRBsaZZOtU8DUgy4S+Ramk4AE
	4ra8dldkq6lt5EFKMW9QDBWWSr2P7loPakpUF+UrxMF/oL4l60Ox5vB1HqaXnRZ8OQ/Q/6iR/Aq
	7r2iSmQklT+V5+j4V9s4sNajEKcl2qQJC3j2g5dQt6SE3tJkHBTlIu22hQQrvzvG/SX07IeDa57
	rKVZoZnB2PjbEJ1D5GINSFcZPeP5vddOno2K2kcX8NUyWJCUMxqGn60ZGqtQtqYfd42LznpQDu2
	GnjjoS2G1KOP8XvdBA74PzldIdCSSEYU5s/D
X-Google-Smtp-Source: AGHT+IHlaXfGjOGCpgIzKRFn/PG3VXXHLz6/IwU5ZevNl3k4vvBiVkhNC4X8bL+NhWCjlFdBgdmMptIXWPYRrY2i67A=
X-Received: by 2002:a17:906:181b:b0:b76:bfa9:5ae7 with SMTP id
 a640c23a62f3a-b76bfa95b6amr192759466b.29.1764046848703; Mon, 24 Nov 2025
 21:00:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-3-alistair.francis@wdc.com> <49bbe54a-4b55-48a7-bfb4-30a222cb7d4f@oracle.com>
 <CAKmqyKN4SN6DkjaRMe4st23Xnc3gb6DcqUGHi72UTgaiE9EqGw@mail.gmail.com>
 <0d77853e-7201-47c4-991c-bb492a12dd29@oracle.com> <13cf56a7-31fa-4903-9bc2-54f894fdc5ed@oracle.com>
 <CAKmqyKObzFKHoW3_wry6=8GuDBdJiKQPE6LWPOUHebwGOH2PJA@mail.gmail.com>
 <1cc19e43-26b4-4c38-975e-ab29e0e52168@oracle.com> <CAKmqyKMjZWAvbc23JQ358kyWyJ0ZajHd8o0eFgF-i1eXX85-jA@mail.gmail.com>
 <14f4ee67-d1dc-4eb0-a677-9472a36ae3bc@oracle.com>
In-Reply-To: <14f4ee67-d1dc-4eb0-a677-9472a36ae3bc@oracle.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 25 Nov 2025 15:00:21 +1000
X-Gm-Features: AWmQ_bkgAASdqK_4byjwJ9DXTwVH0wYVdnA1PBPJyGs2R0SyTlWoIYyHqbjO9pk
Message-ID: <CAKmqyKNJ3BsooptPxMAhrhQZnCVaq_gnnhCrv66+eoTpWvpOww@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] net/handshake: Define handshake_sk_destruct_req
To: Chuck Lever <chuck.lever@oracle.com>
Cc: hare@kernel.org, kernel-tls-handshake@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-nfs@vger.kernel.org, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, kch@nvidia.com, hare@suse.de, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 11:51=E2=80=AFPM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On 11/18/25 7:45 PM, Alistair Francis wrote:
> > On Sat, Nov 15, 2025 at 12:14=E2=80=AFAM Chuck Lever <chuck.lever@oracl=
e.com> wrote:
> >>
> >> On 11/13/25 10:44 PM, Alistair Francis wrote:
> >>> On Fri, Nov 14, 2025 at 12:37=E2=80=AFAM Chuck Lever <chuck.lever@ora=
cle.com> wrote:
> >>>>
> >>>> On 11/13/25 9:01 AM, Chuck Lever wrote:
> >>>>> On 11/13/25 5:19 AM, Alistair Francis wrote:
> >>>>>> On Thu, Nov 13, 2025 at 1:47=E2=80=AFAM Chuck Lever <chuck.lever@o=
racle.com> wrote:
> >>>>>>>
> >>>>>>> On 11/11/25 11:27 PM, alistair23@gmail.com wrote:
> >>>>>>>> From: Alistair Francis <alistair.francis@wdc.com>
> >>>>>>>>
> >>>>>>>> Define a `handshake_sk_destruct_req()` function to allow the des=
truction
> >>>>>>>> of the handshake req.
> >>>>>>>>
> >>>>>>>> This is required to avoid hash conflicts when handshake_req_hash=
_add()
> >>>>>>>> is called as part of submitting the KeyUpdate request.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> >>>>>>>> Reviewed-by: Hannes Reinecke <hare@suse.de>
> >>>>>>>> ---
> >>>>>>>> v5:
> >>>>>>>>  - No change
> >>>>>>>> v4:
> >>>>>>>>  - No change
> >>>>>>>> v3:
> >>>>>>>>  - New patch
> >>>>>>>>
> >>>>>>>>  net/handshake/request.c | 16 ++++++++++++++++
> >>>>>>>>  1 file changed, 16 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/net/handshake/request.c b/net/handshake/request.c
> >>>>>>>> index 274d2c89b6b2..0d1c91c80478 100644
> >>>>>>>> --- a/net/handshake/request.c
> >>>>>>>> +++ b/net/handshake/request.c
> >>>>>>>> @@ -98,6 +98,22 @@ static void handshake_sk_destruct(struct sock=
 *sk)
> >>>>>>>>               sk_destruct(sk);
> >>>>>>>>  }
> >>>>>>>>
> >>>>>>>> +/**
> >>>>>>>> + * handshake_sk_destruct_req - destroy an existing request
> >>>>>>>> + * @sk: socket on which there is an existing request
> >>>>>>>
> >>>>>>> Generally the kdoc style is unnecessary for static helper functio=
ns,
> >>>>>>> especially functions with only a single caller.
> >>>>>>>
> >>>>>>> This all looks so much like handshake_sk_destruct(). Consider
> >>>>>>> eliminating the code duplication by splitting that function into =
a
> >>>>>>> couple of helpers instead of adding this one.
> >>>>>>>
> >>>>>>>
> >>>>>>>> + */
> >>>>>>>> +static void handshake_sk_destruct_req(struct sock *sk)
> >>>>>>>
> >>>>>>> Because this function is static, I imagine that the compiler will
> >>>>>>> bark about the addition of an unused function. Perhaps it would
> >>>>>>> be better to combine 2/6 and 3/6.
> >>>>>>>
> >>>>>>> That would also make it easier for reviewers to check the resourc=
e
> >>>>>>> accounting issues mentioned below.
> >>>>>>>
> >>>>>>>
> >>>>>>>> +{
> >>>>>>>> +     struct handshake_req *req;
> >>>>>>>> +
> >>>>>>>> +     req =3D handshake_req_hash_lookup(sk);
> >>>>>>>> +     if (!req)
> >>>>>>>> +             return;
> >>>>>>>> +
> >>>>>>>> +     trace_handshake_destruct(sock_net(sk), req, sk);
> >>>>>>>
> >>>>>>> Wondering if this function needs to preserve the socket's destruc=
tor
> >>>>>>> callback chain like so:
> >>>>>>>
> >>>>>>> +       void (sk_destruct)(struct sock sk);
> >>>>>>>
> >>>>>>>   ...
> >>>>>>>
> >>>>>>> +       sk_destruct =3D req->hr_odestruct;
> >>>>>>> +       sk->sk_destruct =3D sk_destruct;
> >>>>>>>
> >>>>>>> then:
> >>>>>>>
> >>>>>>>> +     handshake_req_destroy(req);
> >>>>>>>
> >>>>>>> Because of the current code organization and patch ordering, it's
> >>>>>>> difficult to confirm that sock_put() isn't necessary here.
> >>>>>>>
> >>>>>>>
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>>  /**
> >>>>>>>>   * handshake_req_alloc - Allocate a handshake request
> >>>>>>>>   * @proto: security protocol
> >>>>>>>
> >>>>>>> There's no synchronization preventing concurrent handshake_req_ca=
ncel()
> >>>>>>> calls from accessing the request after it's freed during handshak=
e
> >>>>>>> completion. That is one reason why handshake_complete() leaves co=
mpleted
> >>>>>>> requests in the hash.
> >>>>>>
> >>>>>> Ah, so you are worried that free-ing the request will race with
> >>>>>> accessing the request after a handshake_req_hash_lookup().
> >>>>>>
> >>>>>> Ok, makes sense. It seems like one answer to that is to add synchr=
onisation
> >>>>>>
> >>>>>>>
> >>>>>>> So I'm thinking that removing requests like this is not going to =
work
> >>>>>>> out. Would it work better if handshake_req_hash_add() could recog=
nize
> >>>>>>> that a KeyUpdate is going on, and allow replacement of a hashed
> >>>>>>> request? I haven't thought that through.
> >>>>>>
> >>>>>> I guess the idea would be to do something like this in
> >>>>>> handshake_req_hash_add() if the entry already exists?
> >>>>>>
> >>>>>>     if (test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags=
)) {
> >>>>>>         /* Request already completed */
> >>>>>>         rhashtable_replace_fast(...);
> >>>>>>     }
> >>>>>>
> >>>>>> I'm not sure that's better. That could possibly still race with
> >>>>>> something that hasn't yet set HANDSHAKE_F_REQ_COMPLETED and overwr=
ite
> >>>>>> the request unexpectedly.
> >>>>>>
> >>>>>> What about adding synchronisation and keeping the current approach=
?
> >>>>>> From a quick look it should be enough to just edit
> >>>>>> handshake_sk_destruct() and handshake_req_cancel()
> >>>>>
> >>>>> Or make the KeyUpdate requests somehow distinctive so they do not
> >>>>> collide with initial handshake requests.
> >>>
> >>> Hmmm... Then each KeyUpdate needs to be distinctive, which will
> >>> indefinitely grow the hash table
> >>
> >> Two random observations:
> >>
> >> 1. There is only zero or one KeyUpdate going on at a time. Certainly
> >> the KeyUpdate-related data structures don't need to stay around.
> >
> > That's the same as the original handshake req though, which you are
> > saying can't be freed
> >
> >>
> >> 2. Maybe a separate data structure to track KeyUpdates is appropriate.
> >>
> >>
> >>>> Another thought: expand the current _req structure to also manage
> >>>> KeyUpdates. I think there can be only one upcall request pending
> >>>> at a time, right?
> >>>
> >>> There should only be a single request pending per queue.
> >>>
> >>> I'm not sure I see what we could do to expand the _req structure.
> >>>
> >>> What about adding `HANDSHAKE_F_REQ_CANCEL` to `hr_flags_bits` and
> >>> using that to ensure we don't free something that is currently being
> >>> cancelled and the other way around?
> >>
> >> A CANCEL can happen at any time during the life of the session/socket,
> >> including long after the handshake was done. It's part of socket
> >> teardown. I don't think we can simply remove the req on handshake
> >> completion.
> >
> > Does that matter though? If a cancel is issued on a freed req we just
> > do nothing as there is nothing to cancel.
>
> I confess I've lost a bit of the plot.

Ha, we are in the weeds a bit.

>
> I still don't yet understand why the req has to be removed from the
> hash rather than re-using the socket's existing req for KeyUpdates.

Basically we want to call handshake_req_submit() to submit a KeyUpdate
request. That will fail if there is already a request in the hash
table, in this case the request has been completed but not destroyed.

This patch is deconstructing the request on completion so that when we
perform a KeyUpdate the request doesn't exist. Which to me seems like
the way to go as we are no longer using the request, so why keep it
around.

You said that might race with cancelling the request
(handshake_req_cancel()), which I'm trying to find a solution to. My
proposal is to add some atomic synchronisation to ensure we don't
cancel/free a request at the same time.

You are saying that we could instead add a new function similar to
handshake_req_submit() that reuses the existing request. I was
thinking that would also race with handshake_req_cancel(), but I guess
it won't as nothing is being freed.

So you would prefer changing handshake_req_submit() to just re-use an
existing completed request for KeyUpdate?

Alistair

>
>
> --
> Chuck Lever

