Return-Path: <netdev+bounces-277684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIZ3LX0N2mmVyAgAu9opvQ
	(envelope-from <netdev+bounces-277684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 10:59:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2FD3DF117
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 10:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 854E530131F8
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 08:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159393264FF;
	Sat, 11 Apr 2026 08:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sc0RvIxf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AC42E282B;
	Sat, 11 Apr 2026 08:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775897968; cv=none; b=qAF/z3u2SASpgeW9hX0KAuAcRI6fcdCM8ToO2vcctJLI3wI8oB3S+lqBjndA3nShKvZcDGvVstcExOgPUa41vWpHhi8vvmZop+ft6VtrpOM2HHm0i7CTIhmoAs0G4mWfyPQZW3uvNzK5xcuQDTbkgp9tobfnZiOgVAtIw7H9aCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775897968; c=relaxed/simple;
	bh=U0y4F0cMiPdW7z5ltpMmdf5H9ihTv4d9Zot3RLWEfQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X280eucT37wJtnkjATwivHtiJdCf9yTLLu6/pFTTbpnrlL7wHk1FFkRJ8WfwQ3lUVuzaLZ8y+F0ngic6dGR0B5OydM1+IpKdq/11Zf4bA0n/h9xZA/zHKzTTyMtUQpnGAFMaaP5FBcgXWCPMaFdtF33fcQ+qQlauftGbnvic6uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sc0RvIxf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D05C4CEF7;
	Sat, 11 Apr 2026 08:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775897967;
	bh=U0y4F0cMiPdW7z5ltpMmdf5H9ihTv4d9Zot3RLWEfQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sc0RvIxflbf/nOabBNEwBmMBjUdOMmi0Vwcuj+WjaI44K0FGEZqTyqEKrsiONm6X6
	 7Nemx3BsEdCTrDv3FAd0/bEasGiTPmnZD/Ro6XUWBsn8dbak3q7ezaEoG+f0UpL3kO
	 LV00UZPIrRMpwCybDsDNgzctv3/Eg5wCWQlpWbZ0=
Date: Sat, 11 Apr 2026 10:58:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: hugh@blemings.id.au
Cc: Kuniyuki Iwashima <kuniyu@google.com>, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, stable@kernel.org,
	workflows@vger.kernel.org, yizhe@darknavy.com
Subject: Re: [PATCH net] netrom: do some basic forms of validation on
 incoming frames
Message-ID: <2026041124-hyphen-circulate-34ae@gregkh>
References: <20260410145448.38253e3c@kernel.org>
 <20260410221220.1708137-1-kuniyu@google.com>
 <4f5810a7-c792-4d6b-9f7c-6c6b289def19@blemings.org>
 <2026041135-shindig-trekker-5d06@gregkh>
 <b9355e3c-9252-4dd7-b7ed-dff13e3b2c8b@blemings.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9355e3c-9252-4dd7-b7ed-dff13e3b2c8b@blemings.org>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277684-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC2FD3DF117
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 11, 2026 at 05:24:17PM +1000, Hugh Blemings wrote:
> 
> On 11/4/2026 15:50, Greg KH wrote:
> > On Sat, Apr 11, 2026 at 08:25:19AM +1000, Hugh Blemings wrote:
> > > On 11/4/2026 08:11, Kuniyuki Iwashima wrote:
> > > > From: Jakub Kicinski <kuba@kernel.org>
> > > > Date: Fri, 10 Apr 2026 14:54:48 -0700
> > > > > On Fri, 10 Apr 2026 14:30:42 -0700 Jakub Kicinski wrote:
> > > > > > On Fri, 10 Apr 2026 07:24:36 +0200 Greg Kroah-Hartman wrote:
> > > > > > > On Thu, Apr 09, 2026 at 08:32:35PM -0700, Jakub Kicinski wrote:
> > > > > > > > Or for simplicity we could also be testing against skb_headlen()
> > > > > > > > since we don't expect any legit non-linear frames here? Dunno.
> > > > > > > I'll be glad to change this either way, your call.  Given that this is
> > > > > > > an obsolete protocol that seems to only be a target for drive-by fuzzers
> > > > > > > to attack, whatever the simplest thing to do to quiet them up I'll be
> > > > > > > glad to implement.
> > > > > > > 
> > > > > > > Or can we just delete this stuff entirely?  :)
> > > > > > Yes.
> > > > > > 
> > > > > > My thinking is to delete hamradio, nfc, atm, caif.. [more to come]
> > > > > > Create GH repos which provide them as OOT modules.
> > > > > > Hopefully we can convince any existing users to switch to that.
> > > > > > 
> > > > > > The only thing stopping me is the concern that this is just the softest
> > > > > > target and the LLMs will find something else to focus on which we can't
> > > > > > delete. I suspect any PCIe driver can be flooded with "aren't you
> > > > > > trusting the HW to provide valid responses here?" bullshit.
> > > > > > 
> > > > > > But hey, let's try. I'll post a patch nuking all of hamradio later
> > > > > > today.
> > > > > Well, either we "expunge" this code to OOT repos, or we mark it
> > > > > as broken and tell everyone that we don't take security fixes
> > > > > for anything that depends on BROKEN. I'd personally rather expunge.
> > > > +1 for "expunge" to prevent LLM-based patch flood.
> > > > 
> > > > IIRC, we did that recently for one driver only used by OpenWRT ?
> > > > 
> > > > 
> > > If the main concern here is ongoing maintenance of these Ham Radio related
> > > protocols/drivers, can we pause for a moment on anything as dramatic as
> > > removing from the tree entirely ?
> > Sure, but:
> > 
> > > There is a good cohort of capable kernel folks that either are or were ham
> > > radio operators who I believe, upon realising that things have got to this
> > > point, will be happy to redouble efforts to ensure this code maintained and
> > > tested to a satisfactory standard.
> > We need this code to be maintained, because as is being shown, there are
> > reported problems with it that will affect these devices/networks that
> > you all are using.  So all we need is a maintainer for this to be able
> > to take reports that we get and fix things up as needed.  I know you
> > have that experience, want to come back to kernel development, we've
> > missed you :)
> 
> That's most kind Greg, thank you, have missed all you cool kids too :)
> 
> More seriously though - I'd be up for doing it, but I think there may be
> others better placed than I who haven't yet realised we have this conundrum.
> I'm nudging a few folks offline on this front.

The main "conundrum" is, is that this protocol completly trusts the
hardware to give the kernel the "correct" data.  So if you trust the
hardware to work properly, it will be fine, but as the fuzzing tools are
finding, if the data from the hardware modems is a bit out-of-spec,
"bad" things can happen.

I don't know how well controlled the data is from these devices, if it's
just a "pass through" from what they get off the "wire" or if the
devices always ensure the protocol packets are sane before passing them
off to the kernel.  That's going to be something you all with the
hardware is going to have to determine in order to keep this a working
system over time.  Especially given that this is a wireless protcol
where you "have" to trust the remote end.

thanks,

greg k-h

