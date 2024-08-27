Return-Path: <netdev+bounces-122359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A38960CC8
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3BC283F98
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500BE1C3F0D;
	Tue, 27 Aug 2024 13:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ej785GW/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DC41C2DD8;
	Tue, 27 Aug 2024 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767182; cv=none; b=h/1FltFIAmYagWNM1ArdIFMrjt+tgqSCJ55f0EGI2tbT2rW83pqqMQxIU/3R6YviTDsZrHSxt4Itftg0qy1ETj3nh6DgqK4CMHRlLYCQwjk1xTZkRvWFhLTpMiGj9WoRWTZeVbhC3n1NnUC6bDuHRVkMDyV1nAA907stgybqHKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767182; c=relaxed/simple;
	bh=a89ZI3RFXA6YQYq1bevFWz3hL6zd3Z+1MGbouUOUPV0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QZ3EnNhORTBZOa0abKInYJ8pXrpg6Tuec9aQ7UbP2gif8L9sDWC3b2ivdPFf9f8JVCrsTDul3cTBIfY12WeMuY51cT404XHrUUx9z745lTw6MzgcPGgQQEHHK6WLGNaaw/BooyrJ4oC9yPL3UnrPve2gIGD+1I4HeSW5W4IZsKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ej785GW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0C7C61048;
	Tue, 27 Aug 2024 13:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724767180;
	bh=a89ZI3RFXA6YQYq1bevFWz3hL6zd3Z+1MGbouUOUPV0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ej785GW/F71tVCj6Shkjf0OOcLB0lDZzJUJf7m/cf8L5bnVAN8RuIXN+7F+K/zuYW
	 VE/x5qP3Un+clfqSn+YxaG69TmFCFtz6MYJ+/USndvGUfULBWsgzuvmu+k0yMvX5I0
	 edKSiD0YIit2bxF/ZuNADFpE3FinkzNkc0oqkayq4tWL2oPU+YxYRYylPEEgFHnnPX
	 Src7qVHXPJkFef0KYTkatNyRaNk8qxIY0B5qnMcx1kYjhGjmOFED8nf1VoSlqqVVB4
	 ndEsgQ9pd5EXGxHsqra+JGKzpjUNHriL/qR3RfQR3o84MXD1b3bhQlvSjH+HUUbgbm
	 uxiTmjS/kMscg==
Date: Tue, 27 Aug 2024 06:59:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maksym Kutsevol <max@kutsevol.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Breno Leitao
 <leitao@debian.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] netcons: Add udp send fail statistics to netconsole
Message-ID: <20240827065938.6b6d3767@kernel.org>
In-Reply-To: <CAO6EAnX0gqnDOxw5OZ7xT=3FMYoh0ELU5CTnsa6JtUxn0jX51Q@mail.gmail.com>
References: <20240824215130.2134153-1-max@kutsevol.com>
	<20240824215130.2134153-2-max@kutsevol.com>
	<20240826143546.77669b47@kernel.org>
	<CAO6EAnX0gqnDOxw5OZ7xT=3FMYoh0ELU5CTnsa6JtUxn0jX51Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Aug 2024 19:55:36 -0400 Maksym Kutsevol wrote:
> > > +static ssize_t stats_show(struct config_item *item, char *buf)
> > > +{
> > > +     struct netconsole_target *nt = to_target(item);
> > > +
> > > +     return
> > > +             nt->stats.xmit_drop_count, nt->stats.enomem_count);  
> >
> > does configfs require value per file like sysfs or this is okay?  
> 
> Docs say (Documentation/filesystems/sysfs.txt):
> 
> Attributes should be ASCII text files, preferably with only one value
> per file. It is noted that it may not be efficient to contain only one
> value per file, so it is socially acceptable to express an array of
> values of the same type.

Right, but this is for sysfs, main question is whether configfs has 
the same expectations.

> Given those are of the same type, I thought it's ok. To make it less
> "fancy" maybe move to
> just values separated by whitespace + a block in
> Documentation/networking/netconsole.rst describing the format?
> E.g. sysfs_emit(buf, "%lu %lu\n", .....) ? I really don't want to have
> multiple files for it.
> What do you think?

Stats as an array are quite hard to read / understand

