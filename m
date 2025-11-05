Return-Path: <netdev+bounces-235961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEA7C3771C
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 20:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04F254E40C7
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 19:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BF3334691;
	Wed,  5 Nov 2025 19:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXSEQzGE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A35D25F79A;
	Wed,  5 Nov 2025 19:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762370015; cv=none; b=kzZ2bsFOiBc0Gexu+ougU1DRgOD1lpKj9IX4I2SlBgQc6hTG5Zr8X07HbEzqIxXEvfNjfiyuX5U/tsbZ7OneYP0k+lv4TcoZbiY7BJmN3lCY7vcLEfCh0Xy7PAtWuV4O85FQF1E9tf1d7x+EC4ApeNOOVnCcpaUNFOjh4PusogQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762370015; c=relaxed/simple;
	bh=fxEDV71i494fgbaA63ph/O1FRP1th5rTyVyzo+b/5Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8agrYe9k953OCIWEp79/ZQD7/0LGr2PUeQLubyAr/ETn7TAvJkiSG74y0GkB0vrn7CD55CbteniPUANX/mH0YiH+A/FNNc0Gbx5i/nD7vGSdW02uBdkQksKTWFZhQbFfgwb20IC50cL/JM2Hu87TdFb2wM7KVST8Pd72bDdn8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXSEQzGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F69C116C6;
	Wed,  5 Nov 2025 19:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762370014;
	bh=fxEDV71i494fgbaA63ph/O1FRP1th5rTyVyzo+b/5Fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BXSEQzGEA55+5wJD6fsjxwq+ur3BkYgSaHT0smPBeImFTvk5PRu9gkj7LoZ6/nz79
	 IkP+7x7xX5YFj4P3a/mx4ht5SPw/6vgfAgQ1f7rHdtnFh5BUK2R3Gf71ZN8eXuA31U
	 iVfdAN+DGCUvKt6abnkODt+Iq4miJ/FMvrMsyY7mQNua7kIKO2k0yp/zxrao2SMzuU
	 bk7cCQ5GhZzhMgICv8nmKhhGalset7CJ/Q3iCj28tRYpB0FvPV6ykBq2THtTD6YoTJ
	 wYj3hwsqxEa007M26I+JzWtZY1X20YFJGeW5xfeP3kF+9pl/RxxHj/oFeywSinn2Pz
	 +Rd+DBTuBt0lg==
Date: Wed, 5 Nov 2025 19:13:29 +0000
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Ranganath V N <vnranganath.20@gmail.com>, davem@davemloft.net,
	david.hunter.linux@gmail.com, edumazet@google.com, jiri@resnulli.us,
	khalid@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	skhan@linuxfoundation.org,
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com,
	xiyou.wangcong@gmail.com
Subject: Re: [PATCH v2 0/2] net: sched: act_ife: initialize struct tc_ife to
 fix KMSAN kernel-infoleak
Message-ID: <aQuh2czgE7wmTxbq@horms.kernel.org>
References: <aQoIygv-7h4m21SG@horms.kernel.org>
 <20251105100403.17786-1-vnranganath.20@gmail.com>
 <aQtKFtETfGBOPpCV@horms.kernel.org>
 <CAM0EoMnvjitf-+YFt-qsFHXOnZ4gW3mnXBzMT_-Z6M_XSvWbhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMnvjitf-+YFt-qsFHXOnZ4gW3mnXBzMT_-Z6M_XSvWbhQ@mail.gmail.com>

On Wed, Nov 05, 2025 at 10:09:37AM -0500, Jamal Hadi Salim wrote:
> On Wed, Nov 5, 2025 at 7:59 AM Simon Horman <horms@kernel.org> wrote:
> >
> > On Wed, Nov 05, 2025 at 03:33:58PM +0530, Ranganath V N wrote:
> > > On 11/4/25 19:38, Simon Horman wrote:
> > > > On Sat, Nov 01, 2025 at 06:04:46PM +0530, Ranganath V N wrote:
> > > >> Fix a KMSAN kernel-infoleak detected  by the syzbot .
> > > >>
> > > >> [net?] KMSAN: kernel-infoleak in __skb_datagram_iter
> > > >>
> > > >> In tcf_ife_dump(), the variable 'opt' was partially initialized using a
> > > >> designatied initializer. While the padding bytes are reamined
> > > >> uninitialized. nla_put() copies the entire structure into a
> > > >> netlink message, these uninitialized bytes leaked to userspace.
> > > >>
> > > >> Initialize the structure with memset before assigning its fields
> > > >> to ensure all members and padding are cleared prior to beign copied.
> > > >
> > > > Perhaps not important, but this seems to only describe patch 1/2.
> > > >
> > > >>
> > > >> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> > > >
> > > > Sorry for not looking more carefully at v1.
> > > >
> > > > The presence of this padding seems pretty subtle to me.
> > > > And while I agree that your change fixes the problem described.
> > > > I wonder if it would be better to make things more obvious
> > > > by adding a 2-byte pad member to the structures involved.
> > >
> > > Thanks for the input.
> > >
> > > One question — even though adding a 2-byte `pad` field silences KMSAN,
> > > would that approach be reliable across all architectures?
> > > Since the actual amount and placement of padding can vary depending on
> > > structure alignment and compiler behavior, I’m wondering if this would only
> > > silence the report on certain builds rather than fixing the root cause.
> > >
> > > The current memset-based initialization explicitly clears all bytes in the
> > > structure (including any compiler-inserted padding), which seems safer and
> > > more consistent across architectures.
> > >
> > > Also, adding a new member — even a padding field — could potentially alter
> > > the structure size or layout as seen from user space. That might
> > > unintentionally affect existing user-space expectations.
> > >
> > > Do you think relying on a manual pad field is good enough?
> >
> > I think these are the right questions to ask.
> >
> > My thinking is that structures will be padded to a multiple
> > of either 4 or 8 bytes, depending on the architecture.
> >
> > And my observation is that that the unpadded length of both of the structures
> > in question are 22 bytes. And that on x86_64 they are padded to 24 bytes.
> > Which is divisible by both 4 and 8. So I assume this will be consistent
> > for all architectures. If so, I think this would address the questions you
> > raised.
> >
> > I do, however, agree that your current memset-based approach is safer
> > in the sense that it carries a lower risk of breaking things because
> > it has fewer assumptions (that we have thought of so far).
> 
> +1
> My view is lets fix the immediate leak issue with the memset, and a
> subsequent patch can add the padding if necessary.

Sure, no objections from my side.

