Return-Path: <netdev+bounces-268344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UO5yEn2VuGnTgAEAu9opvQ
	(envelope-from <netdev+bounces-268344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:42:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6E92A20F8
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 828DD304A5A0
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB544377EA5;
	Mon, 16 Mar 2026 23:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="XxsvWGDu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E7B36C0D3
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 23:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773704516; cv=none; b=fLBYETgjkKaFAb946VF8C2rtsWPe8Cup97SzyJ1oOQvTyrUjEQDn2+Vg6qlJ58eUiDET4fuRHNoVX0q0uzIwqau4hCoI4zcttIhTh+YyUVHAb0AaYQzeG8HmEFlBSz/gu+M5QoZTd3jPse2He8Jhn75XhwesmB2bKA0EaR8uhLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773704516; c=relaxed/simple;
	bh=GPG40qgsiWGfnf1HBeZ8ASKYrpHqfbll19YA2ateEtE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kC5meU9lOfs0ZwLarbee3lP/Axh4AMAJ9x4ASZlSEYmlkQKfa26Seq1NEdzJBOqpn3WjyicseKSc392A7u8g3wmQEwnhP1XQfpbtofaHIqR9xrDH0quDKbB8e9kNRb2T/VRqUm9pE6Tlcukvp1sPZpTuA7o/wipP+7hGre/u1CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=XxsvWGDu; arc=none smtp.client-ip=185.70.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1773704505; x=1773963705;
	bh=GPG40qgsiWGfnf1HBeZ8ASKYrpHqfbll19YA2ateEtE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XxsvWGDu/IN4vUaX8G7/9dIgPzaVfiyArlcXkWH4G7abI6Haa7C9Ko2IGiQgo67ih
	 rwvUBxlImxJrkqvaHWz/x7hzBJgPfkl7r9gwjP8qf99ScHvMdkyYYXYZ47ZqCB2Ktk
	 vZKjDZMBe3Xa00zJUlOUGaujz0I4hasJpxdPX+x5XXKTAJM7soR++tCvUApSofjUC9
	 epDDXM30IZH/N008XSqu6JpLGinjpYk6indAXTk3YHJj6mYJ+Y5+X2WkDDzJQChOlC
	 fDhIvN45U8guqk4WuSwRVdA4zs9qAuphSv7+tkipHA4oTaY25k9aLlug2gunPrFkiy
	 kMvWfF9ux9rFA==
Date: Mon, 16 Mar 2026 23:41:41 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: Paul Moses <p@1g4.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net-shapers: clear hierarchy pointer and defer flush frees with RCU
Message-ID: <kml9JrxcP_XGGG4SSCVJO6f8Oi9zTfdJg9NRVZyvu7YAd5dgDy-uBE2m1U6MVY-ponQRFLuWQ6z14W63DCLevPICexEWX_yMQcZrytxCgDM=@1g4.org>
In-Reply-To: <20260316161247.1f472be5@kernel.org>
References: <20260309173450.538026-1-p@1g4.org> <20260310192842.3c3b2070@kernel.org> <hHYLQqDrBCcK_2x6uSbGsBott3QuXe8o-R9tj4vNmw8UUEFxpzoD_PCMiHMyyOnySAtQbJtCAB8yVoCmWxzO07C02Q5o0J6fHu4NLEa-ggY=@1g4.org> <20260316161247.1f472be5@kernel.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: f1e5586f1442cebbc8c2d3a2fe4677b0d66b1bed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[1g4.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[1g4.org:+];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-268344-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CF6E92A20F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Do you actually look at code anymore or just mash a button to generate summ=
aries?



-------- Original Message --------
On Monday, 03/16/26 at 18:12 Jakub Kicinski <kuba@kernel.org> wrote:
On Mon, 16 Mar 2026 18:45:48 +0000 Paul Moses wrote:
> > This is not the right fix. The shaper hierarchy as a while is not under
> > RCU. The problem is that we take a ref on netdev and then lock it,
> > assuming that it's still alive. But it may have gotten unregistered in
> > the meantime. The correct fix is to check that the netdev is still
> > alive after we lock the binding or take RCU from the Netlink side.
>
> Ok I see it now, I didn't care about anything except queue because it's t=
he only
> path that affected both drivers. This is an entirely different issue.

Did you write any of this email or am I just talking to an LLM?


