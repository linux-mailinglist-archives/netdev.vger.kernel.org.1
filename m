Return-Path: <netdev+bounces-99630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8DF8D5882
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 04:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 264A6B22710
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 02:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E636BFCA;
	Fri, 31 May 2024 02:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCaU9/GI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7561D4C7C
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 02:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717121289; cv=none; b=HC9684Az9ILAeQTzpW489st94sXU67PPTcWa4qI50+N2DqIetMDYLqJ0A3WQTvIZcR0t6yTO9KTqMj7xb9WBRAXc44INCNK4yUd7Rl+FFUvFYAygZc8270776zK+r6AYZDrbnSsw6UoDFT8h++GgrKdwZpryP+vEtgVglf+T5+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717121289; c=relaxed/simple;
	bh=5MC0SOOF/9jNNucsP57aN323scpYQHPWMS1SOinKQqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNIud8wBkZ8muoTcUDw8bU/vT1i+2FdFq3RGW/uOjwlwV+5Y+eWlhLiAtUNrS6bRuteHHzFK5kDkaXXu4C4PHCc4RBrixNUq6jlLj6wCKbRTq36BKn+GF743wP2vFexAfzwDPG13UOj2bMO3i3vF0+mvowYG4YjhdeuXDiMhml4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCaU9/GI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17B9C2BBFC;
	Fri, 31 May 2024 02:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717121289;
	bh=5MC0SOOF/9jNNucsP57aN323scpYQHPWMS1SOinKQqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CCaU9/GIRndHSn7Hcqv73HTz9Pb2qXuHSXD62RdT9EiqhKCLlKj8EVYIffG19n/UD
	 HmiTZkSwFRH8dd9Ms+pROdo2r+8YuuEH8Y31wWsxQx5SFAaCl7fzh55PP5hCQsub7g
	 gsgIEVxezf7JMaZREAHv4ACfpZW16c286Rq4+WHyv3oDtVCrv5GqmkHWGdcvjNAFuY
	 T3JcMLukAGO4EfuJgvscQIdqngopD/TPzSRKPbYcVPdVWdNykM4/Eog9wOhObwCIJ9
	 NDIYC6WIr7yFx1zjmo0gSU2lhBr6oIsWy63qeK35Ztsk/icga37EzpLWn6a+DcrJkh
	 iCA4hX87rM4MA==
Date: Thu, 30 May 2024 19:08:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>,
 Larysa Zaremba <larysa.zaremba@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Simon Horman <horms@kernel.org>, Chandan
 Kumar Rout <chandanx.rout@intel.com>
Subject: Re: [PATCH net 3/6] ice: remove af_xdp_zc_qps bitmap
Message-ID: <20240530190807.56956a36@kernel.org>
In-Reply-To: <20240530-net-2024-05-30-intel-net-fixes-v1-3-8b11c8c9bff8@intel.com>
References: <20240530-net-2024-05-30-intel-net-fixes-v1-0-8b11c8c9bff8@intel.com>
	<20240530-net-2024-05-30-intel-net-fixes-v1-3-8b11c8c9bff8@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 30 May 2024 10:39:30 -0700 Jacob Keller wrote:
> +/**
> + * ice_get_xp_from_qid - get ZC XSK buffer pool bound to a queue ID
> + * @vsi: pointer to VSI
> + * @qid: index of a queue to look at XSK buff pool presence
> + *
> + * Returns a pointer to xsk_buff_pool structure if there is a buffer pool
> + * attached and configured as zero-copy, NULL otherwise.
> + */

drivers/net/ethernet/intel/ice/ice.h:758: warning: No description found for=
 return value of 'ice_get_xp_from_qid'

(BTW sorry I didn't manage to get to your series for net-next today =F0=9F=
=98=A3=EF=B8=8F)
--=20
pw-bot: cr

