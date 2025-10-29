Return-Path: <netdev+bounces-233746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB8FC17EFD
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AFA33B3ECC
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C312DECBA;
	Wed, 29 Oct 2025 01:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMclFGt6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79D928030E;
	Wed, 29 Oct 2025 01:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701962; cv=none; b=kDvSxusygfACfGAAiXsNdgPNEzfMBe15Wk7I57rmm8WU6bUr9G8zKii2WvLyZt9lVh9GGJ4a14vDSY62/X/Nt+YMG+9fIKwPono5dAObQTLMGxa8UnBeZcAc9Ptxa3hKiUdizQv6TOt8a+iUs9OgXYhJJNMwqqXdXoLNAP9nqBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701962; c=relaxed/simple;
	bh=TdVf4GG+VvQqkIiqP7oZKfyOWHbs5MmM5eQZ64Mh9Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJU3A9eEOABA0PjbjhQIn+58bT2e58ZyVBQckRlcpQNZnRm+bjxRjzbKiAOpi2grgLutqSI1KT9ZIAnvkp8mG7K2/EWtYY+RoeWtiBKhr81LlE0amtqwjlZAspe2pE9my64DNXgcuzdpw57AGc2fQM/sb+SCvbR4jDqktj7LQe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMclFGt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B54BC4CEE7;
	Wed, 29 Oct 2025 01:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761701961;
	bh=TdVf4GG+VvQqkIiqP7oZKfyOWHbs5MmM5eQZ64Mh9Hg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JMclFGt6R8ki7/nkzVp79KcVOCYlT2e4AvLKmFeZgOkEbKmyGz8+1gUSjSygfZc3A
	 g5BvPW0nDyBmVaDOTamVYbYRiKfKKqPzuefnhTVSd2Voj8sLxEEiofChODKLJ8fbrV
	 ctq8Ostrqtoof54UdON3+x8Wth9WVjhIlYZY7nJKm+Okja/H5FM36dAQ+XBDKy52PR
	 PYhnchDSNhpWR3dtkh0reNBTsApHDzOHzI6SYIjsr0tXIJIafhfqBhZKTvnc1EURp3
	 0OQMfwxIPswR4E71tUa1OdJvO2RcZnVBwUP7mbfTGMLyh1rAWBzg1h3XHNo7HDkQ3J
	 liLRt+2SZJf5Q==
Date: Tue, 28 Oct 2025 18:39:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>, Petr Oros
 <poros@redhat.com>, Prathosh Satish <Prathosh.Satish@microchip.com>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, Jonathan
 Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dpll: add phase-adjust-gran pin attribute
Message-ID: <20251028183919.785258a9@kernel.org>
In-Reply-To: <20251024144927.587097-2-ivecera@redhat.com>
References: <20251024144927.587097-1-ivecera@redhat.com>
	<20251024144927.587097-2-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Oct 2025 16:49:26 +0200 Ivan Vecera wrote:
> +      -
> +        name: phase-adjust-gran
> +        type: s32
> +        doc: |
> +          Granularity of phase adjustment, in picoseconds. The value of
> +          phase adjustment must be a multiple of this granularity.

Do we need this to be signed?

