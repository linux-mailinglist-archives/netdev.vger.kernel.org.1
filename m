Return-Path: <netdev+bounces-77760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53320872D6E
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 04:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E803E1F24995
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 03:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31603134B0;
	Wed,  6 Mar 2024 03:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGjWbbkO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F7112E7C
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 03:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709695194; cv=none; b=jxtoFJMhNnKesBqqsjwnjC5/15+2J7Q1JdcZsWNF22ss7bv9BsLNoMOQ2WV2NKp9ChGfR2A/OxC+ZBcB5gN+fLx+T+gcSaW4DlZZzMdsR2fZV9ViEsgFhHcg2MrKizOE6ldnsDRk6Nwkn0UnA10xKuCucc3VZIYKHvfXwTBwqDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709695194; c=relaxed/simple;
	bh=rPxADrhTox8vO6ZJ27K4E8ZLjrzkqp+541xeGa8RS4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQBpph6aq+TqClEYjFer8yLj8Ku6mjgAyRUJd+D4NFPT2gGLNTwSAt5B/Kx4hxzZxJu95TykMrXejhuUOMgij2S2NllXDa3bXX9mvSCpgHuK2u+tTCYSWaJP3Z20p83nczvauSKeBun0hQ75HH+KvFToD1VIVnUO2t1oMjAxF0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGjWbbkO; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dc0d11d1b7so52353885ad.2
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 19:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709695192; x=1710299992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AklPPjRDd1jIue4itlxDBChotvmMEYqJiDN8JjXr/3E=;
        b=gGjWbbkOwv0Yc3n0kzRlkdO4b3eO7Kg/C41/3qjjNZHjD6nqz3+xxPpz593NF9jfOi
         oiYkIP40AJw6O0P0zS4MqR73d6creGNeJXecBLun8aFv8mTLfLDb3OF+IkFYwsLy2C/m
         2njTBZLj9RSbE34URw3BzaJ0KvA9pL50UwM5DKFJgeltVA01EThxRTYauPqCDDM7lj0a
         QT/X55vk73yqlQk/tzNTHQTtSGhsYLlBqvp6Sk4/lGMV3GNJDv9XGfNYvd2yw8yL5Ioc
         jR1j4n1lTnhBjDNxNzYxNHl9jPz/857BlVG5zPOEWV6Xx6rN4DCXdlPIBQj7ca16eN9I
         fqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709695192; x=1710299992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AklPPjRDd1jIue4itlxDBChotvmMEYqJiDN8JjXr/3E=;
        b=W3ls89yX0UZ2N6iJmvaTFvRQ+zWuECvN1z8pSeSyeThPpbkIQvXRzZEOoz1rdC5aF+
         CODZPPxKYYUfsTEHgtvvmIr6AHwPqglua2nYdTWEAxVVRZb7p/1U9rep3UvTIgCe9CsU
         GmdG4wPRhKo+VRZyeAgHbO2zoOfw7RnKJxM7tHJiaCa4X5Mx1sd3R1QowLyLcJ+kAbuR
         rF+S/ZmbG2PRGJVm5OsyEUFxvBA/gm2MGLRsupUYFgPQBjbPlIkhpP+Nn+B0EDFRzQrH
         GyEbB+DKpIViWqg8AbY5Yk0c1rWNUF1kktBVtwlZg04fvPt6TkGfbaX8jU5bFO8aHRUZ
         hIIg==
X-Gm-Message-State: AOJu0YxQ86+GhkUqqTssEOEsNBFqySzKRYnmEz/sLvY/UOqNUk/lVp57
	F3pz0dSIbLTsDsiZq0x0XOfoSEfzRl4DmPJ1EeqcHg2gudXP/X10GY0t7hEMdy67tQ==
X-Google-Smtp-Source: AGHT+IFDLpxCxFRSCEetDlgm6hobzbI4OYOW+wNiEzoDvBZa/QzpyaZtAt8kBqwky/1/FhEgp1zuog==
X-Received: by 2002:a17:903:2341:b0:1dc:b3ba:40aa with SMTP id c1-20020a170903234100b001dcb3ba40aamr4380881plh.47.1709695192066;
        Tue, 05 Mar 2024 19:19:52 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902654600b001dccff4287csm11508591pln.202.2024.03.05.19.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 19:19:51 -0800 (PST)
Date: Wed, 6 Mar 2024 11:19:47 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: netdev@vger.kernel.org
Subject: Re: bonding: Do we need netlink events for LACP status?
Message-ID: <Zefg0-ovyt5KV8WD@Laptop-X1>
References: <ZeaSkudOInw5rjbj@Laptop-X1>
 <32499.1709620407@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32499.1709620407@famine>

On Mon, Mar 04, 2024 at 10:33:27PM -0800, Jay Vosburgh wrote:
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
> >A customer asked to add netlink event notifications for LACP bond state
> >changes. With this, the network monitor could get the LACP state of bonding
> >and port interfaces, and end user may change the down link port based
> >on the current LACP state. Do you think if this is a reasonable case
> >and do able? If yes, I will add it to my to do list.
> 
> 	I think I'm going to need some more detail here.
> 
> 	To make sure I understand, the suggestion here is to add netlink
> notifications for transitions in the LACP mux state machine (ATTACHED,
> COLLECTING, DISTRIBUTING, et al), correct?  If not, then what

Yes, the LACP mux state. Maybe also including the port channel info.

> specifically do you mean?
> 
> 	Also, what does "change the down link port" mean?

If a port is down, or in attached state for a period, which means the end
of port is not in a channel, or the switch crash. The admin could detect this
via the LACP state notification and remove the port from bond, adding other
ports to the bond, etc.

Thanks
Hangbin

