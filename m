Return-Path: <netdev+bounces-115661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A367E94764E
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 09:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDAF31C20D0A
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 07:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6471442E3;
	Mon,  5 Aug 2024 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Al2b2Mgn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B28113CF86;
	Mon,  5 Aug 2024 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844009; cv=none; b=XjB6J9niLh7NZA5KeuVjbb5HwALyJXBjF9jPdTFfpLuKP4mkpC15eckMJMCPUHMUx/Nod6kVd53L0HOkS4H5Y8GqiQ1ylntD2RfUM42P2eeVfAqRW6CUcnUS21htZ7L1wmmLwq/pXIDZU1/ZLvfh7WMszA/6fjWlJc0JZ6w42wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844009; c=relaxed/simple;
	bh=mXP4Qrow+JnKrJxvaPL5ChNdrMkMtMx8Imb7wNM9JLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOMijOrQ95ezZCfDJhYyxTHqhAPfO6fMQ7mTmilfc0orD3NOfAdgZojbw9nGRj+obxYOi7HzIrUbKVbefI5IAw/PRn7wDaensIC5uCEKWR7CWp9bE4gZGIv5vfBUJJoPaRc9dJpAUekTGzD3JvwSVxIdIif0D9GnlRisBy7jQj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Al2b2Mgn; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39b3ffc570bso3418115ab.3;
        Mon, 05 Aug 2024 00:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722844007; x=1723448807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXP4Qrow+JnKrJxvaPL5ChNdrMkMtMx8Imb7wNM9JLk=;
        b=Al2b2Mgn9slINJJerYDIQQLKIbAV8EZ0YySvXTZTAhxq8HDBqHjq5T9x15qxwuEund
         pjfIj9WUQU6wCtx6DbR7gtVeNy4E4LeaLCq6mGRdUd6Q9zeD4RpIHyZ8bgKMYJOiqPKF
         1NYSQ8h16LHQqTMUzqf/M6ePvS65UYCLlmWPGEjEvI5cx0x3Cy6XfZiznwl4KUR/pX34
         4ZO+tPCyndqTbaO7Dgn3vISkgZCpeqCy5NMt6DQOvHXOI9T9QoUfeTcKExa0hwlFQhtG
         EWlrjK4NA+acBZbQgxswKvH6BLhp4yWBZ10q3ZnYkVvGV+EAItAzKHBpEBs5SPO9XgWu
         zSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722844007; x=1723448807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXP4Qrow+JnKrJxvaPL5ChNdrMkMtMx8Imb7wNM9JLk=;
        b=oxqT4tNpkbO0QrXuehQsVc3Ee52+7uMXKkmGWZFz7d5qV6JnqjrxSHbMHHTwhIxr+I
         +YUQHupCHuUJB3xJOxwNNn0g8LoUrHj39+EcOqa+n84Bn7jg3brnef8bW4WsUFiHJMKL
         Tg1ynvhElogLB8rXhTOtOJd6bVBm4QjMSCGs9rcC0ta5rvp1l6tn/bEvT4DUH8MDneBf
         H4tK8KISYAluiUnmMYwO8ODY9u/ajvhyNm86RcMtqhibJifqDCk7xLxLxR/N3NR94klm
         FszfES4oghKkqxyzbk4kVbMiPB13i9EAJdfCI2ez1vJws31oyE3gLZQqxMj65g+fg7Id
         jvKw==
X-Forwarded-Encrypted: i=1; AJvYcCWXKeV/6itIqfJihFmP8n1jYtu7WckMlFEbTxFlv8Wbc7Eag8oknJVK9NWCUl4CC2Bf/tf4xhoS5K7yyyLy8ewuXqsIbHLIymGTTg8Cthf+ibPzYHAxgnce9gqXNaxbmqTTxM8+
X-Gm-Message-State: AOJu0YxPYjHauPUpv3ciyssyL2KxT1rrU5vz7UD8s6Ekb0fLPs2hbnDh
	H61pvVFpwQRXYjwjFA6vheBefyZmKA2mKxoH4c1jocqAGU75NTLuIU84IaMQ3VnC+LifRt/RzB4
	NGIp78kikzuIGcP1en0FojJSjNz8=
X-Google-Smtp-Source: AGHT+IFjOT0YCdtcO4pkbGFkWPwXuxxSeUA6zhYqlcieAoupl0andq+Hn2l2rOT3srAW9e21mBQ/vyoUAB6lQKLVwKw=
X-Received: by 2002:a05:6e02:1a82:b0:396:bfa6:6f30 with SMTP id
 e9e14a558f8ab-39b1fb6bc91mr171796165ab.6.1722844007251; Mon, 05 Aug 2024
 00:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801111611.84743-1-kuro@kuroa.me> <CANn89iKp=Mxu+kyB3cSB2sKevMJa6A3octSCJZM=oz4q+DC=bA@mail.gmail.com>
 <CAKD1Yr1O+ZHg_oVYu39z=qKPC2CX7P56ewRLWOkvXqvekKk6uA@mail.gmail.com>
In-Reply-To: <CAKD1Yr1O+ZHg_oVYu39z=qKPC2CX7P56ewRLWOkvXqvekKk6uA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 5 Aug 2024 15:46:10 +0800
Message-ID: <CAL+tcoCqGP9fkNVmZ5U0vLyCcFDgWS8s=QDate8BPyopKSn39A@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix forever orphan socket caused by tcp_abort
To: Lorenzo Colitti <lorenzo@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Xueming Feng <kuro@kuroa.me>, 
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 2:43=E2=80=AFPM Lorenzo Colitti <lorenzo@google.com>=
 wrote:
>
> On Thu, Aug 1, 2024 at 10:11=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> > > This patch removes the SOCK_DEAD check in tcp_abort, making it send
> > > reset to peer and close the socket accordingly. Preventing the
> > > timer-less orphan from happening.
> > > [...]
> >
> > This seems legit, but are you sure these two blamed commits added this =
bug ?
> >
> > Even before them, we should have called tcp_done() right away, instead
> > of waiting for a (possibly long) timer to complete the job.
> >
> > This might be important when killing millions of sockets on a busy serv=
er.
> >
> > CC Lorenzo
> >
> > Lorenzo, do you recall why your patch was testing the SOCK_DEAD flag ?
>
> I think I took it from the original tcp_nuke_addr implementation that
> Android used before SOCK_DESTROY and tcp_abort were written. The
> oldest reference I could find to that code is this commit that went
> into 2.6.39 (!), which already had that check.
>
> https://android.googlesource.com/kernel/common/+/06611218f86dc353d5dd0cb5=
acac32a0863a2ae5
>
> I expect the check was intended to prevent force-closing the same socket =
twice.
>

Yes, I guess so.

