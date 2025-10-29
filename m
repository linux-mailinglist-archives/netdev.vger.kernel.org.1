Return-Path: <netdev+bounces-233706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC28C17788
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA5B1A660B4
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA2A1531E8;
	Wed, 29 Oct 2025 00:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xit7G/gd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37292145355
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 00:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696356; cv=none; b=bRqW4ZfHWnyOMulOvIr+OrtWcON2g3fzwpG4MVJRzI0gAt1JsB8B6GSAKN26CpgpXn66dQp67Y8znkSM00Ot9AgUzNTRvphNMoem7IL0iYXnFp3ZH+44zVe//e/v/93BQtgZJbmF7NfcFaffplpbyMloonQXbbWtO0SxTgVIiog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696356; c=relaxed/simple;
	bh=+nZ1/bCt5sE1bYchpJgWL4utFqRlhdTBnQgeUEP4JYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FA4kfmZdBz5hWjwmCvaKUUM2qKp45NlEYHKOQ9+pAptUOCMeSpcGDI0D40VmRQCUpb59cNEexgxmfuXTkaOaCe+nYm5t70bpBoTMwhTknlebKUX7YWeFJlZ+w7lTB7LYzK8uUkFawijOPSUff/T4IEGihWcKR1n6PaisknBQetw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xit7G/gd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A737C4CEE7;
	Wed, 29 Oct 2025 00:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761696355;
	bh=+nZ1/bCt5sE1bYchpJgWL4utFqRlhdTBnQgeUEP4JYk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xit7G/gd8XUm8KJl/W8Ws9Xe0HFez3UEbFTjM6mm6xixpo+b+USv/c3yQmCeaJg91
	 nKQqZr2maNzDHAyf0VTvD1jS1mks3uO5BgFvQ0nfU/J3IdP+ltYM7+N4qKdAKCDeS5
	 r0EKoxjlEo4q74ijWgS4a5osMZ1tDB3BOPHxoIOUf2LNO0JaHHclAw7xwRaF3UoAkq
	 a1FPgTVQ4lTSVMzjlW95e25IkrTpLkytdZH+9WTfoRxyosxBuwfPn4yhE0oxRJS1+b
	 1ZkxV5Z0IBNjCIwCe7q9cguBljJ1QeF3yeCqg/hf/0Vp3ePgQhP3THqMZbr/VSrzk0
	 9+n4G+qelwpng==
Date: Tue, 28 Oct 2025 17:05:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: YonglongLi <liyonglong@chinatelecom.cn>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org
Subject: Re: [PATCH net v2 1/2] net: ip: add drop reasons when handling ip
 fragments
Message-ID: <20251028170554.3588ee28@kernel.org>
In-Reply-To: <44342ead-92c9-4467-b5e6-86076684e2ee@chinatelecom.cn>
References: <1761532365-10202-1-git-send-email-liyonglong@chinatelecom.cn>
	<1761532365-10202-2-git-send-email-liyonglong@chinatelecom.cn>
	<44342ead-92c9-4467-b5e6-86076684e2ee@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Oct 2025 15:34:48 +0800 YonglongLi wrote:
> Hi Jakub,
>=20
> Thank you for your response. I'm sorry for the late reply.
> =E2=80=8CMy email system seems to have some issues, and I loss  your repl=
y msg.
> I get your response information from web page: https://lore.kernel.org/ne=
tdev.

So you resent the patches again? Please learn to use the ML correctly.

Also, again the subject tag should be [PATCH net-next] here not net

> > FRAG_OUTPUT_FAILED means something failed in output so it'd be more
> > meaningful to figure out what failed there, instead of adding
> > a bunch of ${CALLER}_OUTPUT_FAILED =20
>=20
> The skb send failed in output() is frag skb, The skb droped outside of ou=
tput() is the
> origin skb. I think if we want to get detail drop reason we can use kfree=
_skb_reason
> in output() (maybe anther patch set in future).
> In my opinion, drop reason of the origin skb outside of output() can be n=
ot so meaningfull.

Do you have practical examples of output() failing? Are they in any way
related to the skb being fragmented? My intuition is that they would
not be, hence the fragmentation is not very relevant.

If the output() failed because there's something _special_ about
fragmented datagrams -- I'd agree with you. So let's see some
examples..
--=20
pw-bot: cr

