Return-Path: <netdev+bounces-73788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8628985E6A0
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 19:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395A81F2828C
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 18:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B7D85937;
	Wed, 21 Feb 2024 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+RmWH5K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7DD83CDC
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708541377; cv=none; b=ncz7X2gd1xhJnOMa/lGAdsDQJg+IJMk/eDwkTPM/eqYjw1ZzSBjeIhL+NSIDUMsMYt6mIZ6cVIohmJhZr7FDQpUZzuEqsXbQJOxWcmG8EMHhl9fwnaAeMvmj7wruVEgWrlD6RaXK5G1QfXKfbBoe8A83XHMfHs/iX6wqgFhrJN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708541377; c=relaxed/simple;
	bh=0Lr9xDoREe1ZuMg+05FTCTx7rUSpNhVCLrzaFrzmx+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ko1yT+0wsOkHgZkVUn8//SjOOJJOC9IqfxrpqiPl/ViJA7p15VFJ+OFrOH3FYFXyqkZF2fpctUzfjI/lzxgCuf3fpUpcL6ofBM+NRa8pRbB7XXkHLWRSpeMulLJweKGt40aoTgRk1fqmDeIlrPnEg7meVuqBJGWZQcwyHdCitWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+RmWH5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4A3C433C7;
	Wed, 21 Feb 2024 18:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708541377;
	bh=0Lr9xDoREe1ZuMg+05FTCTx7rUSpNhVCLrzaFrzmx+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t+RmWH5KJEaeT70OZBwl0tG1U2r46NCHyOK9FgD7VraZwJgZ7Ql80tqtWDuBBY3y7
	 i7xGDFxr2BToPsnIN9DMcLhjQmSpTTgprpS30C9XG6+XMfKOf8dinyMWiZ2+yRUSbj
	 2OWE0fyqSeAGDHo/J9tAMromTkX1z/Lo3Qr4ueipX+/REOuxoivUSlrOy3HqV8eP0R
	 QDev+w+j6GacN+HJuCG+be6TFbViaqJafPsmULbJzOWdL5NwpzLmRCppATNkEJ/3iF
	 qnqSACPz2rkKdjijwFgEG1CjwnA2Vydme8xBZ21LCzTWFBBgEEbTdl1kN1rc1rHH1n
	 7E369sp+aoH3Q==
Date: Wed, 21 Feb 2024 10:49:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com,
 swarupkotikalapudi@gmail.com, donald.hunter@gmail.com, sdf@google.com,
 lorenzo@kernel.org, alessandromarcolini99@gmail.com
Subject: Re: [patch net-next v2 3/3] tools: ynl: allow user to pass enum
 string instead of scalar value
Message-ID: <20240221104936.7c836f83@kernel.org>
In-Reply-To: <20240221155415.158174-4-jiri@resnulli.us>
References: <20240221155415.158174-1-jiri@resnulli.us>
	<20240221155415.158174-4-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 16:54:15 +0100 Jiri Pirko wrote:
> +    def _encode_enum(self, attr_spec, value):
> +        try:
> +            return int(value)
> +        except (ValueError, TypeError) as e:
> +            if 'enum' not in attr_spec:
> +                raise e
> +        enum = self.consts[attr_spec['enum']]
> +        if enum.type == 'flags' or attr_spec.get('enum-as-flags', False):
> +            scalar = 0
> +            if isinstance(value, str):
> +                value = [value]
> +            for single_value in value:
> +                scalar += enum.entries[single_value].user_value(as_flags = True)
> +            return scalar
> +        else:
> +            return enum.entries[value].user_value()

That's not symmetric with _decode_enum(), I said:

                     vvvvvvvvvvvvvvvvvvvvvv
  It'd be cleaner to make it more symmetric with _decode_enum(), and
  call it _encode_enum().

How about you go back to your _get_scalar name and only factor out the
parts which encode the enum to be a _encode_enum() ?

