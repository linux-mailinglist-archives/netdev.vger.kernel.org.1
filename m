Return-Path: <netdev+bounces-141316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DD69BA769
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 19:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86F9280DC6
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 18:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16D076036;
	Sun,  3 Nov 2024 18:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCG0FqVd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855D2AD2D;
	Sun,  3 Nov 2024 18:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730658704; cv=none; b=t+u2/VZSgygZ4IoVw5rZxTGV7PJZvBsdRyhJyHRp9Z7QoQR9Fv4/t7BaOvbhW1m9o/gAJ/gVtfB13EAaBYmU5ax3XbCsAljBgJuvLhOP6Xye5miYqaUc4KbN0NKS6fQc3bjDWj8XnPT/iYW7cvdetug1pNNudqVfHoVe/NJ9tzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730658704; c=relaxed/simple;
	bh=4o1UCwUXBUkVa6SFTfLODuZaWt6iLKUAc+n5Wo95l4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AS2ScqfSPDjO+8IiZ3Yr7Alu3yA7vfIDynhLhK+apoH8D1RQ0rsL2mgZar8MRAxVFBsClepg2WA8u1T6IiiVCTu1p97e0eUu3OHUCmD4l6sJNf+Ub3LdGlanmT9LnfteApfXVgxS+qmCecnHhEGBZvQlXoWJYCWv2x0EoKjAw5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCG0FqVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8201AC4CED0;
	Sun,  3 Nov 2024 18:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730658704;
	bh=4o1UCwUXBUkVa6SFTfLODuZaWt6iLKUAc+n5Wo95l4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BCG0FqVduCI4+AnuzOBrTN440kH+ZKfmj3fhTAQb/2JsTdsKp156wJgt/DJXJB44u
	 EKPxNIy2BgTZHU1Q05ZgRAyot+AjUpuzWAAdisEoicpjmN6l8hDgdZHvzE9gfGSm8u
	 ltVYYr4a8/84gqOsu7xp/un+Q1xKCWAYWE0SxLGWqx9ikzwuUehI1BU1MgoRWLlVTW
	 7z9CDjeJD6iiPeoLYgfLMfghBVdpuw89LIkF9gBD9vHAlzOKbXXRoIKF0YD3BsasNT
	 8rUPgAiLxfeIQbL93uzABltqkgWNcPcWh8MppS+R5kPM7Dg3wAIFIKHg33AcbrbVgp
	 4IDqrb9WdsScQ==
Date: Sun, 3 Nov 2024 10:31:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Masahiro Yamada
 <masahiroy@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v2 3/9] lib: packing: add pack_fields() and
 unpack_fields()
Message-ID: <20241103103142.4ba70d58@kernel.org>
In-Reply-To: <20241025-packing-pack-fields-and-ice-implementation-v2-3-734776c88e40@intel.com>
References: <20241025-packing-pack-fields-and-ice-implementation-v2-0-734776c88e40@intel.com>
	<20241025-packing-pack-fields-and-ice-implementation-v2-3-734776c88e40@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 17:04:55 -0700 Jacob Keller wrote:
> +ifdef CONFIG_PACKING_CHECK_FIELDS_1
> +HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_1
> +endif
> +ifdef CONFIG_PACKING_CHECK_FIELDS_2
> +HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_2
> +endif
[...]
> +ifdef CONFIG_PACKING_CHECK_FIELDS_49
> +HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_49
> +endif
> +ifdef CONFIG_PACKING_CHECK_FIELDS_50
> +HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_50

This series is marked as Not Applicable in PW. Not sure why.

I can't bring myself to revive it, tho, this isn't pretty. 
It'd be one thing to do the codegen and the ugly copy / paste
50 times in the lib/ but all drivers have to select all field 
counts they use..

Since all you want is compile time checking and logic is quite
well constrained - can we put the field definitions in a separate
ro section and make modpost validate them?

Also Documentation needs to be extended with basic use examples.

