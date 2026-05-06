Return-Path: <netdev+bounces-285068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJNDE4rF+2lSEgAAu9opvQ
	(envelope-from <netdev+bounces-285068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 00:49:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E104E1617
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 00:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86AF1301386B
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 22:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0F13D0938;
	Wed,  6 May 2026 22:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LPByxj0j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C4F3161A1
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 22:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778107782; cv=none; b=YroTqtNlktwOQms/qCWaNciq9EAG24Noo3cK8JVo92n80q+eGtSX4Wrj2NR1xNpASm7iIPIQ89yR/gdAjkDElihOCGgBy45nmrx/uKrbCRQNPzxKyfsf4F2ZDc5D7oHrwJbK7M+2Mc0bWFlWyAKFibZDn97l/9zYDdScbvgVOXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778107782; c=relaxed/simple;
	bh=W2bOwmgBgbRPOFoHwIWTGbgslfjmN0yKNnT3yBKu9PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luoFeJKAZXJXE6r6YYMmIN49KTjlFLd8ioO/g7P7aRPgB8PSp+bwY5n09rCVXm/FqLWUwF0bBKr0YRpMQ1+jSJpllE2DvzSHNyA8F/dqMQpmkTQ6W5WY5Wbp3/oszi2k9GlC+EZKsF/1QNnwIqfg256tdBlsiTVAl2tYxfhe+zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LPByxj0j; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bab82d75fdso1092735ad.2
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 15:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778107781; x=1778712581; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wB9Jbl6OwNsn+HVcduUaP/1MdPcWg7cvGBqOaohDZOA=;
        b=LPByxj0jry93gsoWzoEAYFKLLpeHZrQgXuvjVOXb5uqOEHTsRW1dput8oG/77Dmy2t
         xWAkcXsoiEcDv8z3ybnEWP4tnp/v3KJEh203mjWslrxq/dsnvVpGU9Id4kNWQOMHc8ij
         WeChbpFENQ4tscumo8QXimNOA/m1IBIzkae+lJM0zAsst0ORIi9iLK84+Ll+u2CJn4YK
         lc382p/iTJAT7sjV/ikjcAAMHcQDXJL1oQjg9kIoFliLty1Q97/dzJvFgfccfAhr5o8J
         KmY8Hms2rm1bu+d2Po3P0MG8WOuwM7OdFidmHFdCGMMf8i/EjSwHDhfzUSUhieyVqO2I
         g1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778107781; x=1778712581;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wB9Jbl6OwNsn+HVcduUaP/1MdPcWg7cvGBqOaohDZOA=;
        b=c9zswPFc2FXIwzBq0wue8ut/UnShYGf4NodGSy2WfMYTfqDja0kuX/zNQJVhkCn3BO
         HUecvXh8ZqFObrfysIgr6Jk/+tI9EuodsbT+Y0Rc6L9gRWkxzk+PesR4/F30poyfDm6O
         SOSjqhz9Thn/P1JeNybh1E07hH3fh+Ma+OfchDroeD7aCX2kDlld8bVWRUbLJ/9k2azc
         3kA7NIHfrDYrwwESVnVCMCry2T1PKVPAFoKmz+xnXCztEyvwm77vYqwupOkQh/+uIgHz
         aFptkVQbxXr/XVUyAPpDZtIPkxqiyuIF1y3xQPvGoHEw9gfwjzF1UW30F2df17CWRoGY
         85Qg==
X-Forwarded-Encrypted: i=1; AFNElJ+ARyzrw7ErjKS+IR9CW4vRQyz08puQGa3gsg8XcaeRqSI8sW3uUksoPZ3qHeYNa2VWENzoGyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJRornAKXNJMEkokW3Yb5SbnqBvhdXLBXo6/CzksDYnMy6mrWF
	TH8H0tp7pGGpQbyPr+6dnxWWnQ5RNPkE3GcD833ENaxoQGTzphhvvSyI1JMAILNj3EM=
X-Gm-Gg: AeBDiesytqoHDeYFJsVF1j03XAeHVtxEBO83Muv4WuvBIbpUxi/4GTOXJZ5V6k25oPC
	EPp3Xne+9y7fTeAWpUTdFOzbAdO3nsxOW7x7dokJQrFSN77pbSxOfC2aHwFQVn+ukQL85INuf8j
	yjs5dmfHDZ8yWbL4RPEptRX4Xtn5eOtAcjsj3dzxNF8o7OECaBvfQGaPujjOvS3jGpQV8aLgSWU
	QzppmGvEtZEtvwAleMiOVJ0KHglEpwD6c4b5ivM6tkPEFvSYkiZdp7LeRxBeRrRCjTqR7qSvjaZ
	6ul5h30eSGiB1fKMIlKDqNtkgK0FLfyGDrz8hBqmjugzKH6e6hRndOY59dS/5nEHFEJTAg+3IGn
	PZefHqL0BWmEuhby7uKCVWAe2Zshvaf6Mu2oPwOFdcyJ9VpfzwtKrXP6qFUDAw4ibjWzYGRWGO4
	Ozeg806QXzTOQFEpUwol7rVRFQbJOLeMQQtP3LWQWW6QA79xg2P5lCVPHsZZvZrt6iiQ==
X-Received: by 2002:a17:903:187:b0:2b2:be01:5532 with SMTP id d9443c01a7336-2ba799d4662mr61394475ad.35.1778107780763;
        Wed, 06 May 2026 15:49:40 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2babaaed237sm2689955ad.27.2026.05.06.15.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 15:49:40 -0700 (PDT)
Date: Wed, 6 May 2026 15:49:35 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH] i40e: Fix i40e_debug() to use struct
 i40e_hw argument
Message-ID: <20260506224935.GD10532-mkhalfella@purestorage.com>
References: <20260428181450.2622899-1-mkhalfella@purestorage.com>
 <558971b7-caea-471a-8fe2-73ba6cc0790a@molgen.mpg.de>
 <20260429165229.GF2686-mkhalfella@purestorage.com>
 <10637b35-766c-454b-b9fc-ac9e6df36da5@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10637b35-766c-454b-b9fc-ac9e6df36da5@intel.com>
X-Rspamd-Queue-Id: 90E104E1617
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285068-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkhalfella@purestorage.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,purestorage.com:mid,purestorage.com:dkim]
X-Rspamd-Action: no action

On Wed 2026-05-06 14:57:26 -0700, Jacob Keller wrote:
> On 4/29/2026 9:52 AM, Mohamed Khalfella wrote:
> > On Wed 2026-04-29 13:02:00 +0200, Paul Menzel wrote:
> >> Dear Mohamed,
> >>
> >>
> >> Thank you for your patch.
> >>
> >> Am 28.04.26 um 20:14 schrieb Mohamed Khalfella:
> >>> i40e_debug() macro takes struct i40e_hw *h as first argument. But the
> >>> macro body uses hw instead of h. This has been working so far because hw
> >>> happen to be the name of the variable in the context where the marco is
> >>
> >> marco → ma*cr*o
> > 
> > Good catch. Also 'happen' should be 'happens'
> > 
> >>
> >>> expanded. Fix the macro to use the passed argument.
> >>
> >> I’d add a Fixes: tag, but the maintainers might have more input.
> > 
> > Yes, I should have added Fixes: tag. I will leave it to the maintainer
> > to decide if v2 is needed to fix the spelling mistakes and add Fixes
> > tag.
> > 
> > Fixes: 5dfd37c37a44 ("i40e: Split i40e_osdep.h")
> > 
> Please send a v2 with the fixes tag and typo. It will make it easier to
> avoid losing this data.

Done https://lore.kernel.org/all/20260506224123.691160-1-mkhalfella@purestorage.com/

