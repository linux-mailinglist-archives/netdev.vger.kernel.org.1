Return-Path: <netdev+bounces-133371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C2C995BDC
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02572878B3
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8669C2139CB;
	Tue,  8 Oct 2024 23:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkqn4DtD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6284B1D0B8B
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 23:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728431341; cv=none; b=q2MUT3G9VNVmIldbp0+UgNPsIw8+sPPRBDPv55JRCKD7Q2BUDv3h5E7OJV1yibZDl97xSFORKzkn/9d1kDpNKGvpvqN2eAOnYLpmf60I0ZUReK7551CE2kVhcQsvdxCL/Mm9pQRBeir09k+P5fnpQfb4xu4+zc/KGwx3lHvGf2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728431341; c=relaxed/simple;
	bh=Vj0fdw62X4AqPYIwnPvSBlAk1899znmC4XfRPqTGVIU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JPc6qYJAwRz+hxinxzvGbvPK0z+RxtSYl1uA+o4v0eMBQGj0Gd7J4V3RoBtQAJ/AcE5OCoT1HESpAG5RPnZs8pEpO0IDE+K4CRF6c34nvCn3pI9flTsiWmWdGnCFd+tLyzKiQubs2MYiExhxClDcq1sCe3f7EWMfY/GHHCklyg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkqn4DtD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1C9C4CEC7;
	Tue,  8 Oct 2024 23:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728431340;
	bh=Vj0fdw62X4AqPYIwnPvSBlAk1899znmC4XfRPqTGVIU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gkqn4DtDWLXlBwl8lZQe/Ln9sxmzB0t0t9k+q1jgLZuZ8/Yf9ksWqjcAa+4YNhdXm
	 tk5eadKn7gvUbyUTjhWX4YjrI8737jHVfBFUBiSKdSFzlcKPIPMLt84ZvynXQbs/Fv
	 F8B53R/QLIWjUxmPwGi3EvTWMjQODt6FAfCBdzJ1R3vAJXa3JadHyjVDh0pbzK5cZN
	 1eWUDgjZldbFjnFMjdjSvg0KAR3GCSyGiRqnK+GwV+SjJf06zL1frA6tY6eOVKyE3f
	 EZAQihIYplnbWmTyMSKlcAR5LNb5F+cBJ7XPR4zEfakNGFvXfwAyvqJXbdY2hATUAM
	 zNpIWzZnIW0tA==
Date: Tue, 8 Oct 2024 16:48:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com, Stanislav Fomichev
 <stfomichev@gmail.com>
Subject: Re: [PATCH v8 net-next 09/15] net: shaper: implement introspection
 support
Message-ID: <20241008164859.23553374@kernel.org>
In-Reply-To: <7523bf4d6f19429efd32192dd5b90f7bb0b0b20d.1727704215.git.pabeni@redhat.com>
References: <cover.1727704215.git.pabeni@redhat.com>
	<7523bf4d6f19429efd32192dd5b90f7bb0b0b20d.1727704215.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 15:53:56 +0200 Paolo Abeni wrote:
> The netlink op is a simple wrapper around the device callback.
> 
> Extend the existing fetch_dev() helper adding an attribute argument
> for the requested device. Reuse such helper in the newly implemented
> operation.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

