Return-Path: <netdev+bounces-225475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2ABB93F16
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 04:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA11448495
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 02:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1232271A9D;
	Tue, 23 Sep 2025 02:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bX9xsQVP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5313226B2D2
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 02:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758593238; cv=none; b=VSLbJQpPxVupJoy1H8IS3NPCdXEak7M9z0Q/kow0yG4rqmHAlTKZC5IcJp40l4MtKNJx2Y7PAoYRYI1ZoABXgJM0j05MuFS7lN5Ce9/5A9vNvbo4RIyKirHJigJk6jVGJMMSj6cT0F/spy/qxiTtbC9AeO9ERAv12911h5V5fOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758593238; c=relaxed/simple;
	bh=MRlBwg2VR4zhkZFPOBIJyEsnC4HaYFMMyEQY7TKIMl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgBYbUgrbCMpNqCINPY+ueX9qPMz8RYY+E394YxS9j81Xjz0EdYs8IKjBM4otgadGaBZA4TU0EvYVuI74mNFo9vfj4G7ymh/KCeucyYUbhLTXKeGJRth0l+xb7cbwWgMKNMDA6pskaHCtQsln44VBLWKkQgPdz+21S1Mp9iTfO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bX9xsQVP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2570bf605b1so64985615ad.2
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 19:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758593234; x=1759198034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MRlBwg2VR4zhkZFPOBIJyEsnC4HaYFMMyEQY7TKIMl8=;
        b=bX9xsQVPHoN7a1aBou5n+0WM4pMcawqLi3gvd8+Pa767zh+x1XSH1Kbq3uVnE1mKDK
         tS8mNL/NTHAKToMhh9gKOlkD/NwxSakxbV4JTR1UVh82EeprXl4rf9BhBnz+B/3G5xt5
         XhVJEQaqcmfFB3Q3xT8X86VFNiAJVxpCYD4T9N5p+MOXtK4/per0bic/PvL3CF5y4Vyc
         9HVyq7k/+aZv/fY7YQmKNdvM1N7UJWxdE2WLlPVi/YVMArRJyq7y0l9erliCHWx75ECh
         WA4mWCfPV578KaCfWYPVGzWEXtrsLBb0TYIlZN210YjRaCIdsu3FuRFEWD0hr4Lhk4co
         gqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758593234; x=1759198034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRlBwg2VR4zhkZFPOBIJyEsnC4HaYFMMyEQY7TKIMl8=;
        b=lcau3MOLJYJKbjpLh2AtRBfHDmKpf6Yy7ZXM+IizyZLzwRhnXI+dnDE0EDSsGPwFeZ
         GI68eC7hQfJAdv9UHouGzcHyJliMVgsqtZUcrAysbC278tOuNYMShxSKXEM1N2tSL3Sl
         8CeFi/XTSmSlcOOzj6CMH9ll0ZGiRGlGclLpCOVy7//J102SpsL7oAvkCNDmyeSK8YE+
         peH2YRI80RIPSV2syAjQSBiaUlQFvyudrN5rQ6rcsxzpzSkosJihcCOc0HtZS/ayQOv1
         CROShp/vE6O9/fBC/AUHAagUYkg6n6yXANiWDIYZe6vTVjvY1Xoo+36oCCVWQIZKW0b8
         9tWQ==
X-Gm-Message-State: AOJu0YwPEv1lyOoi5WdRTBsHmOBTobkR4IiWRFPHT6Sf5H11omsNmZgQ
	F8uM7e270QaGrHOrHkFFLX3ZTon+jlShFS2NTUmlO+OmnDXHThiEc7Kq
X-Gm-Gg: ASbGncsCprKPQsOkwIdIZuGMfyArlBgdp3WFTz/JZwvojeNE3EaWaPFXzMjNvc9m5bZ
	AW2qCinP/eCB2k0w6gQFXpppwbCZDQYABH2v2Qq8zhnwNhOCWy4rR5KrfW8lictYFE+K/mjDvrR
	DKA9k8awTtqXMuOALHSpIwU32VuKBiy/WjVR5xYi56Y0AFiVxwZT0loyg3nkUuniaOPFJIbJMiX
	aijfR2LSjQN4XH8Hy+rEpTYG6Z9SjSWXdwjrPvKVfsZEK/gs2bZrdzyAWBOsA8W2RVS7bQE41Pp
	pksoOQZISMc92npTWkyRiWUZrV+dOeimlt//wKDzGtEQ2SjOQXs2sZVwhiCaKe9wIz2MYMVh0nK
	4VtzCmpLAYefxI0sdSFAShDagO+c=
X-Google-Smtp-Source: AGHT+IE0+PWJUQMS01eA+Ju+sRk+tquHKei3LeDGfeGroqZ3Ex1WCkVIuEUgaJxxBmpZMRU8UHhafQ==
X-Received: by 2002:a17:903:37ce:b0:24c:f589:661 with SMTP id d9443c01a7336-27cc0fa8314mr11935885ad.11.1758593234474;
        Mon, 22 Sep 2025 19:07:14 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980180bdesm144946805ad.56.2025.09.22.19.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 19:07:13 -0700 (PDT)
Date: Tue, 23 Sep 2025 02:07:06 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Zengbing Tu <tuzengbing@didiglobal.com>
Subject: Re: [net-next v8 2/3] net: bonding: add broadcast_neighbor netlink
 option
Message-ID: <aNIAytaEhRGVTRvu@fedora>
References: <cover.1751031306.git.tonghao@bamaicloud.com>
 <76b90700ba5b98027dfb51a2f3c5cfea0440a21b.1751031306.git.tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76b90700ba5b98027dfb51a2f3c5cfea0440a21b.1751031306.git.tonghao@bamaicloud.com>

On Fri, Jun 27, 2025 at 09:49:29PM +0800, Tonghao Zhang wrote:
> User can config or display the bonding broadcast_neighbor option via
> iproute2/netlink.

Hi Tonghao,

Have you post the iproute2 patch? I can't find it.

Thanks
Hangbin

