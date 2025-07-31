Return-Path: <netdev+bounces-211241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B6BB17552
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 18:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58BD3B9FED
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 16:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C289423AB85;
	Thu, 31 Jul 2025 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlYAoigh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA711C07C3;
	Thu, 31 Jul 2025 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753980862; cv=none; b=GrWCG2riOHnI2jb222CpKU9b4pPK1V4Ekifd9JEkzRbrHtBT8Fu5+EuqdwSbo44mfOydwMbbcVVbYK700oQW2vYUwShYYtmgacmI5q5T0UkIJUjBgBoY2UwquW/hjMIQ5LKOHw1hIBhFsUY0pvsQMcxaBlZmbqLVbGG5zYOxaRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753980862; c=relaxed/simple;
	bh=RFT+unNz9YD8n7J2IfXYOln4J96Jv/o5vG/NxjuMD14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbqfC5L7V/gvQzN4+WWKd2MIJqobmM6ruqt322z5kRI+JHUWWyIVrgrFjvxMIWtAtvdcNaskfVhhhIdMa4Lf4pairRRgVzlVY/OnescYRxWv+S56qQzheIaYmMgBQLG2Jki+d2fMzYZ0BEgrkADssaUmIjF7Rf25uu/B+ve7fNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlYAoigh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07711C4CEEF;
	Thu, 31 Jul 2025 16:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753980862;
	bh=RFT+unNz9YD8n7J2IfXYOln4J96Jv/o5vG/NxjuMD14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nlYAoighajV+2KB/yai024exQXQhpbPmK7A8oy6k3uj9hM2tawrN4In0RGQ67WvEM
	 7DhBDXejbr8R32LYDPhsFb0p0hrMJ2S+Uo6jz+Dv3gGGRjb32ADxYI1Cwl4xTbkgSG
	 Tmge34PHiSY1pkDiIWqH/QtrKO4LDkv33+u2dZAKEE0WAA6GzqkedEhrazBlNN6/vo
	 dIfSGPCmyLO6uwyFbq5g2vitx72P0CHDAQlJPEnuK+pvsRPxyd4Fe05UNP8NLV0LJJ
	 fqyIy5fyX42VyalhgbrLrRZj1rqHejWpY4jAgJeTfOZ4S6RoteOK0PWjXjOoNg+nKX
	 6GslmxrM5XmIA==
Date: Thu, 31 Jul 2025 09:54:21 -0700
From: Kees Cook <kees@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Krzysztof Karas <krzysztof.karas@intel.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Qasim Ijaz <qasdev00@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v15 6/9] ref_tracker: automatically register a file in
 debugfs for a ref_tracker_dir
Message-ID: <202507310952.7255AA30@keescook>
References: <20250618-reftrack-dbgfs-v15-0-24fc37ead144@kernel.org>
 <20250618-reftrack-dbgfs-v15-6-24fc37ead144@kernel.org>
 <202507301603.62E553F93@keescook>
 <6270c853cdf90172d4794e2b601ebc88590b774f.camel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6270c853cdf90172d4794e2b601ebc88590b774f.camel@kernel.org>

On Thu, Jul 31, 2025 at 06:29:00AM -0400, Jeff Layton wrote:
> "If you think you can justify it (in comments and commit log) well
> enough to stand up to Linus’s scrutiny, maybe you can use “%px”, along
> with making sure you have sensible permissions."
> 
> Is making it only accessible by root not sensible enough? What are
> "sensible permissions" in this instance?

Yes, I should have been more clear (or probably should update the
document), but root (uid==0) isn't a sufficient permission check, as
address exposure is supposed to be bounded by capabilities. Putting a
filename into the tree exposes the address to anything that can get a
file listing, and DAC access control isn't granular enough.

(Thank you again for the fix patch I saw in the other thread!)

-- 
Kees Cook

