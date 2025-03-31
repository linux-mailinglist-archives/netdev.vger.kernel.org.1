Return-Path: <netdev+bounces-178294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2401FA766D0
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 15:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618E018861DB
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 13:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B132116F5;
	Mon, 31 Mar 2025 13:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JlYPF5mv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JlYPF5mv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20D217A2FA
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743427580; cv=none; b=bz0gFx3tmTaipZWLShl2PsU0SsuVxgG9ZjdQG4C7jEvq0mNuXEISEOfz5CPxu4d17Obo+uvCDe//mp72yb7z+tp4UQ+ZxYdCycL3/ngTmK3XHNYZ4oNG6l7LrUzuCGI4RDz0hk2BdFTHVC6ex/tJfoOogADMU7EY8X42RNqtsTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743427580; c=relaxed/simple;
	bh=AgUbHTOk1aX6DaqWnXp8nE4696aoYEOt5p1DXo63Nss=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=akEu+Qw3GH1tZnSJqueoLw+6A7XZTFtIpYAYKtDC7W/5HMQVBMoq5vp48S7tgoTm7GeKvihXW0BgJ4uSs26xh55qhIej9//IkZb7nPNL98vNpPPnmXzfjtKF4XH06XaWBVR7isrpehYTdyP5NfKunQ0VNGou2ttqtaTu6yX3Jz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JlYPF5mv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JlYPF5mv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C057F21180;
	Mon, 31 Mar 2025 13:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743427576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AgUbHTOk1aX6DaqWnXp8nE4696aoYEOt5p1DXo63Nss=;
	b=JlYPF5mvpzC+Te+38/TbGEswSoK7FYeBmUS51pfcH1df9aeruHCcIrTQsQ0o4ab+rVDEtM
	8d32BPW3uxchJ3FFRqff4+SQ/sjQssq5L3gSNzvnVBYnzdk0AlNQ9ajSNwZcnU+usZBnP2
	WAG+4owxvGQs1ct8PFKg4HOHMHva4eg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743427576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AgUbHTOk1aX6DaqWnXp8nE4696aoYEOt5p1DXo63Nss=;
	b=JlYPF5mvpzC+Te+38/TbGEswSoK7FYeBmUS51pfcH1df9aeruHCcIrTQsQ0o4ab+rVDEtM
	8d32BPW3uxchJ3FFRqff4+SQ/sjQssq5L3gSNzvnVBYnzdk0AlNQ9ajSNwZcnU+usZBnP2
	WAG+4owxvGQs1ct8PFKg4HOHMHva4eg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FCA113A1F;
	Mon, 31 Mar 2025 13:26:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CjH8IfiX6meJIQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Mon, 31 Mar 2025 13:26:16 +0000
From: Oliver Neukum <oneukum@suse.com>
To: gregkh@linuxfoundation.org,
	bjorn@mork.no,
	loic.poulain@linaro.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 0/4] USB: wdm: fix WWAN integration issue 
Date: Mon, 31 Mar 2025 15:25:00 +0200
Message-ID: <20250331132614.51902-1-oneukum@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [0.70 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	SUBJECT_ENDS_SPACES(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.00)[27.67%];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 0.70
X-Spam-Flag: NO

The original integration of WWAN left a few race conditions
and deficiencies in error handling


