Return-Path: <netdev+bounces-198196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1255ADB90A
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 20:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F26D173734
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 18:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63064288C16;
	Mon, 16 Jun 2025 18:47:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC151C7017;
	Mon, 16 Jun 2025 18:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750099646; cv=none; b=jqHJYBkhQcHLWK304S3lXwG3RgYSr+18EklRBC+odifmz05LvpmTZP62VTB0KdXTNMkDUeMZfaO050enLYHxCyZGFGw007GMqSzfN0P5+TgM0vwldc3+M3fkjd3f+ZpJiR3LlvHA4xx/l9I4Og9WJJ+a8vJUQcDBxXy4NAEnjDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750099646; c=relaxed/simple;
	bh=+u6NIt7sxAbAcBUXeniPYLozYeGS9fVseDfzYPam3aA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=doqrKzsmOBYPephUlfEWKllbuyYWUc21JZ0HZv3blHdCPz3VQzFCpUEPPqoioXC5nb5umpVB4Pt+f2ZZUEKC2JsYkytopCkQRTvPCiflrPabUYp7ymChkBpIAxRASmeN0JIe6JxV8wfLQn6Nr+rIkl3dtFp4eTCzSLm5OjVvvIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 1E0E480CE4;
	Mon, 16 Jun 2025 18:47:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 0A83420013;
	Mon, 16 Jun 2025 18:47:19 +0000 (UTC)
Date: Mon, 16 Jun 2025 14:47:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, netdev@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Eric Dumazet <edumazet@google.com>, Neal
 Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH] net/tcp_ao: tracing: Hide tcp_ao events under
 CONFIG_TCP_AO
Message-ID: <20250616144718.4e8e12bf@batman.local.home>
In-Reply-To: <20250614153003.GP414686@horms.kernel.org>
References: <20250612094616.4222daf0@batman.local.home>
	<20250614153003.GP414686@horms.kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 0A83420013
X-Stat-Signature: xesxf9bh9c5ri4ep9wzkp8y4rtsfehj9
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19jT6mTF9UAA3Sd8LvPn4fMEC2UAzwUSpo=
X-HE-Tag: 1750099639-458386
X-HE-Meta: U2FsdGVkX1/ts7w0SxBLUpEGFjhG+2khnklr2JJmL3vQPwHvlwIFdxrN0q+NChc9H0e4y8Qln7DDTQijjJJvEui/2X06f0Pk/xazhotjyChetScSmrk2qM0jQtodiU3MW0ldiJ22coQePoEjSlrSEGbx+dHNADYsu3bVLw9DuR5k/bPfEL4Jlmf3gg7alkN1aqhQuc3nQlzNzY6m3o7BT70ghYkm32QrFKxl2N2589Ir1nbJLsSy0nozNY2vC9FmYSMf3EO94H1MZl8y1oAQebWYRIMANxmIqPYPMdmUUAvt6tOYqVto0GLAbEBL3W0oy1rcpESjIq6VgVDVjkRcZiLyZqmcDFIP

On Sat, 14 Jun 2025 16:30:03 +0100
Simon Horman <horms@kernel.org> wrote:

> I agree that the events and classes covered by this #define
> are not used unless CONFIG_TCP_AO is set. And that the small
> number of TCP_AO related events that are left outside
> the define are used even when CONFIG_TCP_AO is not set.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Thanks,

Should I take this or should this go through the networking tree?

-- Steve

