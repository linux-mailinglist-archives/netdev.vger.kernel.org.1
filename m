Return-Path: <netdev+bounces-229446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F61CBDC5B0
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 05:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 973E04E3133
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 03:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543E129BDA9;
	Wed, 15 Oct 2025 03:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfiZNw19"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3E721ABAA
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 03:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760499389; cv=none; b=T5oAwETorMpp9H2Ou4RuPYljjmC1RZ2KoGNPKzjz1SSRnZEnbaXsw/ShSqlAJ+CHditOddLfJoMgoZyb4etyb/qJvP9AmfqbWbatlemrpDVRdv1QfW/Yp3jBoZz3gmZoDPNJ1q15pj2Obysdqan/EnHa9yY6J5XGoSdUh7hHAls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760499389; c=relaxed/simple;
	bh=ZRiPWlChbTX8QD34/GocV2uiR6hTkWmH7awH8K5lg+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Znd6CWNoNFDHNhdpzqOTChmXNwcXfcemARL70Ci/U1+YVWrI7KwruRm5GL67h2liD666QGSqcwCxSpHYnta8GZ99WZ7ElLTkgG0CTWKAPdNs8DEWz1JrT4FNDMnb2aEmh53tRWZ2UeXphFEmg9vqg7DRCl4CK1SQtuUEZityS2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfiZNw19; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so3850930a12.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 20:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760499387; x=1761104187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jklX+1/Pw1F3UPnYdJ4RZq1dg6P2hKnec2uCFgxHyYI=;
        b=LfiZNw19QhmDut1r2q5uX8DibQUGpAm9Hq6uFmUZ9PGGu7efnStnxp8syYwj2asH35
         GU7aZ9C0KUreIJn6FZ/u3zqyq3DkAYt0uF54E9PCptb0SA7Czu7okaShaW+ylm/n0oph
         MR5d1qPOVxEwDvid6kXwQTaRMsmoJMqfgc29SxbCJRQfiz8xBTfo7HFQ8wdF1lHxSKcg
         PFLsCXB2on//qZwk8hz7oE14M5AZuQUT/geX51Hd4kGgcwprIlO2tWUFYqTqDSY4SOdZ
         xzvHyGML0/o2DLCC64wxpBDtwrBpTIi3xdGwRkkc1UdbSJ82uS0zDoA4ipBmb7Z8443c
         ETXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760499387; x=1761104187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jklX+1/Pw1F3UPnYdJ4RZq1dg6P2hKnec2uCFgxHyYI=;
        b=W/2KaWhuEKg9kYXyFFZmrhjIIGYy0QoJH+fBruHv97N1pYizDawfirNPNNzWtHlG9h
         I6cSe6rPjliUhZuT5dQfOJGTooetChvTdePGAypRSLcQbvq+ha9RBwsPnyipc11zzgPB
         EkDXJ+KWbfyO7Rl9Tv561VWb/r80qCvxdkl0mcEx2HkMCE6sYQXKoAQFODxRzBN3ePeM
         0pxW2FLLHuCghNOaOJUqKvdnV/m/bH4CWBrAaL5pOn6Y+cygpKd//nVh1dfEHDl//hwm
         AtOPyjSuVxp3lUJgWWZwPkJMEHWIx/jEzRTRqYil0d/KNVEd8ij/rPNF8dn6XnJa1+uC
         HIYA==
X-Gm-Message-State: AOJu0YxhxwShuRnZXMPpCDUfH7CPfhzhaO72MZY5dpNCsBlXWQpXCebZ
	ZhEmyi8GSz9/nQBX8ObqNYkU1kR6KGeFh4SobRTvZw+uJE4z3TSbHWI9
X-Gm-Gg: ASbGncuW5powTXKsM27iq/M1B9FgA3XgDEHp3XMBd7SuXkgBdN0AXMyBcuyL6HmcGxk
	PvD8o3fe5U/HmM4RkVOsyqqxjNupbCnWvVS7Yb6yaOV7FqEjxL6zSwmiMW4zWz/5JIZp/IrgkWm
	FqRh1Q6So5r0UIEUx+pntC4Q678vZZRcdQdfgGUcSFvUoLj6sHTm6pO8oBPSQf6RNbDq0GqcGZX
	x3ywCZfqfhe9qnVLnxvYegUTQJzXKs3Rb+d63mEmBRaTcZ7ZCXh1bbgeDrqEvrplZhEfMUKO4/d
	WMlvezluxYLKP9XEdSs0nEGbsXq4s6ENIJRGq8aRcZNOWg90oSjg0hkXy+t9VziFaR/rVNiungn
	Gcc1+lNNDff6/JV971sOqlm5UDARjN4pCWHc86fGagkS3CyzKW4qhQSep
X-Google-Smtp-Source: AGHT+IHfSbDZYeePRUk7AUk5UIU+8/HST88SCuQrgfaeFYNIi4uWGC/HFLBZ8gSHUE5RZPD73lTd1A==
X-Received: by 2002:a17:902:d50f:b0:278:9051:8ea9 with SMTP id d9443c01a7336-290272dc4a7mr374811585ad.40.1760499387069;
        Tue, 14 Oct 2025 20:36:27 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29084078e2bsm16777145ad.64.2025.10.14.20.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 20:36:26 -0700 (PDT)
Date: Wed, 15 Oct 2025 03:36:18 +0000
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
	Zengbing Tu <tuzengbing@didiglobal.com>,
	Antoine Tenart <atenart@kernel.org>
Subject: Re: [net-next v8 3/3] net: bonding: send peer notify when failure
 recovery
Message-ID: <aO8WsjvT_kY_rL2v@fedora>
References: <cover.1751031306.git.tonghao@bamaicloud.com>
 <3993652dc093fffa9504ce1c2448fb9dea31d2d2.1751031306.git.tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3993652dc093fffa9504ce1c2448fb9dea31d2d2.1751031306.git.tonghao@bamaicloud.com>

On Fri, Jun 27, 2025 at 09:49:30PM +0800, Tonghao Zhang wrote:
> +static void ad_cond_set_peer_notif(struct port *port)
> +{
> +	struct bonding *bond = port->slave->bond;
> +
> +	if (bond->params.broadcast_neighbor && rtnl_trylock()) {

Hi Tonghao,

When do our internal review, Antoine pointed that this rtnl_trylock() may
fail and cause the notify not send. The other places of bonding using
workqueues to reschedule when the rtnl_trylock() failed. Do you think
if we should also do some similar thing to avoid notify failed?

Thanks
Hangbin
> +		bond->send_peer_notif = bond->params.num_peer_notif *
> +			max(1, bond->params.peer_notif_delay);
> +		rtnl_unlock();
> +	}
> +}

