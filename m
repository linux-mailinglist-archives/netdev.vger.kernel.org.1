Return-Path: <netdev+bounces-192554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FE9AC060E
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 09:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F8B3BC97C
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 07:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1257C223DD0;
	Thu, 22 May 2025 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HWMWhS4E"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15004221701;
	Thu, 22 May 2025 07:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747900076; cv=none; b=VtsWoL1bEWbi0UdLQEnlMGrcrG/15erc+MLXZmk54Pvn5Os1RHRCSLIPWFv1/UQY2IuA/YdcO9I51Rxc7lfdRsxGUoF4NRnrCFneWTl5fNuiDodogV89qnd/D1zZuLrddWp63ZqSm5DACwv74kzhw7aM+tPsOkq0OxpU90WiPC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747900076; c=relaxed/simple;
	bh=smdC8ntSuFz7RbikksRDtXxPHa88CKXItvJ63BI/zOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BcM/Yu5iFeHZruSY62IeT8nikOv/LxXRURBoKrXBiFepa0NZ5zrwrjmhB2u2/CKKdPPCDrRF4MEkP67ORZgiHzmMjekz9pk5558OOjzyp1OsZlac54ZWhBwZwf2RMcstO+sQi1DnrunpnNYm83QsAnel9O4FRmF6nxIviWSlUAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HWMWhS4E; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M7bKdm020411;
	Thu, 22 May 2025 07:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=7M0sfJKDDhqb/GaL/zQpAc5hzFTOs
	OvUTCDnKGL48Ug=; b=HWMWhS4E1skoqYcrvlV/j07qNTrOxtXSzT1+ScUccxK5E
	xcJXUELJ5fMEDPAVANUtDwPF6jS/mvuowKbdXLnJ5Wla0p3RXdt6NM2/7xOOPiTs
	mtwl4MfyXFZCaQNAvSLiFH6HnW7kcqBD0eIzbKoBO5rGHHbi0W42hVUPEK4+Elku
	6NoLyj38/wXJPGcRNJP+jUJGEI7LuHeosqkAKfoBTPuseSBfiHG+IVP2Y0cN5Tj4
	VWEh57HZrk2g8NOr3wXvAtEMjz+Vmwdf5hvkOZROdyqVRvs7mIn4l0gy9CEOZIji
	RULYYjX6Wn+blQw3vXFYB1bpAswhA+ix6JZ15ZqAg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46syphr0dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 May 2025 07:47:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54M66YIE011260;
	Thu, 22 May 2025 07:47:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46rwep3p4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 May 2025 07:47:38 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54M7lcSC025608;
	Thu, 22 May 2025 07:47:38 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46rwep3p4b-1;
	Thu, 22 May 2025 07:47:38 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, darren.kenny@oracle.com
Subject: [PATCH] ixgbe: Fix typos and clarify comments in X550 driver code
Date: Thu, 22 May 2025 00:47:26 -0700
Message-ID: <20250522074734.3634633-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505220077
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA3NyBTYWx0ZWRfXz6y3jFZ3aK2b XVoGHrGO1K3dtyjca2CYBeL5DPzy599thWzuSn0fz8QIbjJnZ2PRZLNzcLgVM0n57mzbwGmjKkL A5vZ2JHqr9GeyzsnTNgHk4k+dPi+e0WwtyCFa/rI52SNyoI+G2IS1ff4Qss/2oSjlJZtPnsc41E
 WZvH0oRoaLgvXi6x/VPkFdfvolpM5wmjZ0A+p7Z+o5dY5io4Je4Ud4GoGqnRyTjiaBwZD92ljgp p4TrILBuuVw4yz3jXsWizHkuQDN1P5VVLd20G/TPL0VJdGVFf+R1j4Fow+GQj9p0k3GZ/AieS1E hYH0JUuNfTEAo6HUXB31fqQSe/H/LKpsb8Sssvh78zBC1jx+CL1k1SCBS68n0kf109Tq0kWcJVx
 p6aARgUmH0Ivnrvl+WmBoxblUIyQzpGZez9N2vyJlNtU9aZdj5FOCr7yoOh6MaM5Rw2DEoIy
X-Authority-Analysis: v=2.4 cv=aNTwqa9m c=1 sm=1 tr=0 ts=682ed69b b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=NBsIVx0fIra5UVodnlcA:9 cc=ntf awl=host:14714
X-Proofpoint-ORIG-GUID: ZuEMEtUNLP6oWblbaPdDzloteqsQRbXO
X-Proofpoint-GUID: ZuEMEtUNLP6oWblbaPdDzloteqsQRbXO

Corrected spelling errors such as "simular" -> "similar",
"excepted" -> "accepted", and "Determime" -> "Determine".
Fixed including incorrect word usage ("to MAC" -> "two MAC")
and improved awkward phrasing.

Aligned function header descriptions with their actual functionality
(e.g., "Writes a value" -> "Reads a value").
Corrected typo in error code from -ENIVAL to -EINVAL.
Improved overall clarity and consistency in comment across various
functions.

These changes improve maintainability and readability of the code
without affecting functionality.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 277ceaf8a793..57f68a1addfe 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -20,7 +20,7 @@ static int ixgbe_get_invariants_X550_x(struct ixgbe_hw *hw)
 	struct ixgbe_phy_info *phy = &hw->phy;
 	struct ixgbe_link_info *link = &hw->link;
 
-	/* Start with X540 invariants, since so simular */
+	/* Start with X540 invariants, since so similar */
 	ixgbe_get_invariants_X540(hw);
 
 	if (mac->ops.get_media_type(hw) != ixgbe_media_type_copper)
@@ -48,7 +48,7 @@ static int ixgbe_get_invariants_X550_a(struct ixgbe_hw *hw)
 	struct ixgbe_mac_info *mac = &hw->mac;
 	struct ixgbe_phy_info *phy = &hw->phy;
 
-	/* Start with X540 invariants, since so simular */
+	/* Start with X540 invariants, since so similar */
 	ixgbe_get_invariants_X540(hw);
 
 	if (mac->ops.get_media_type(hw) != ixgbe_media_type_copper)
@@ -685,7 +685,7 @@ static int ixgbe_iosf_wait(struct ixgbe_hw *hw, u32 *ctrl)
 	return 0;
 }
 
-/** ixgbe_read_iosf_sb_reg_x550 - Writes a value to specified register of the
+/** ixgbe_read_iosf_sb_reg_x550 - Reads a value to specified register of the
  *  IOSF device
  *  @hw: pointer to hardware structure
  *  @reg_addr: 32 bit PHY register to write
@@ -847,7 +847,7 @@ static int ixgbe_read_iosf_sb_reg_x550a(struct ixgbe_hw *hw, u32 reg_addr,
 
 /** ixgbe_read_ee_hostif_buffer_X550- Read EEPROM word(s) using hostif
  *  @hw: pointer to hardware structure
- *  @offset: offset of  word in the EEPROM to read
+ *  @offset: offset of word in the EEPROM to read
  *  @words: number of words
  *  @data: word(s) read from the EEPROM
  *
@@ -1253,7 +1253,7 @@ static int ixgbe_get_bus_info_X550em(struct ixgbe_hw *hw)
 
 /**
  * ixgbe_fw_recovery_mode_X550 - Check FW NVM recovery mode
- * @hw: pointer t hardware structure
+ * @hw: pointer to hardware structure
  *
  * Returns true if in FW NVM recovery mode.
  */
@@ -1267,7 +1267,7 @@ static bool ixgbe_fw_recovery_mode_X550(struct ixgbe_hw *hw)
 
 /** ixgbe_disable_rx_x550 - Disable RX unit
  *
- *  Enables the Rx DMA unit for x550
+ *  Disables the Rx DMA unit for x550
  **/
 static void ixgbe_disable_rx_x550(struct ixgbe_hw *hw)
 {
@@ -1754,7 +1754,7 @@ ixgbe_setup_mac_link_sfp_n(struct ixgbe_hw *hw, ixgbe_link_speed speed,
 	ret_val = ixgbe_supported_sfp_modules_X550em(hw, &setup_linear);
 
 	/* If no SFP module present, then return success. Return success since
-	 * SFP not present error is not excepted in the setup MAC link flow.
+	 * SFP not present error is not accepted in the setup MAC link flow.
 	 */
 	if (ret_val == -ENOENT)
 		return 0;
@@ -1804,7 +1804,7 @@ ixgbe_setup_mac_link_sfp_x550a(struct ixgbe_hw *hw, ixgbe_link_speed speed,
 	ret_val = ixgbe_supported_sfp_modules_X550em(hw, &setup_linear);
 
 	/* If no SFP module present, then return success. Return success since
-	 * SFP not present error is not excepted in the setup MAC link flow.
+	 * SFP not present error is not accepted in the setup MAC link flow.
 	 */
 	if (ret_val == -ENOENT)
 		return 0;
@@ -2324,7 +2324,7 @@ static int ixgbe_get_link_capabilities_X550em(struct ixgbe_hw *hw,
  *	 PHY interrupt is lsc
  * @is_overtemp: indicate whether an overtemp event encountered
  *
- * Determime if external Base T PHY interrupt cause is high temperature
+ * Determine if external Base T PHY interrupt cause is high temperature
  * failure alarm or link status change.
  **/
 static int ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc,
@@ -2669,7 +2669,7 @@ static int ixgbe_setup_internal_phy_t_x550em(struct ixgbe_hw *hw)
 	if (status)
 		return status;
 
-	/* If link is not still up, then no setup is necessary so return */
+	/* If the link is still not up, no setup is necessary */
 	status = ixgbe_ext_phy_t_x550em_get_link(hw, &link_up);
 	if (status)
 		return status;
@@ -2768,7 +2768,7 @@ static int ixgbe_led_off_t_x550em(struct ixgbe_hw *hw, u32 led_idx)
  *  Sends driver version number to firmware through the manageability
  *  block.  On success return 0
  *  else returns -EBUSY when encountering an error acquiring
- *  semaphore, -EIO when command fails or -ENIVAL when incorrect
+ *  semaphore, -EIO when command fails or -EINVAL when incorrect
  *  params passed.
  **/
 int ixgbe_set_fw_drv_ver_x550(struct ixgbe_hw *hw, u8 maj, u8 min,
@@ -3175,7 +3175,7 @@ static void ixgbe_read_mng_if_sel_x550em(struct ixgbe_hw *hw)
 	hw->phy.nw_mng_if_sel = IXGBE_READ_REG(hw, IXGBE_NW_MNG_IF_SEL);
 
 	/* If X552 (X550EM_a) and MDIO is connected to external PHY, then set
-	 * PHY address. This register field was has only been used for X552.
+	 * PHY address. This register field has only been used for X552.
 	 */
 	if (hw->mac.type == ixgbe_mac_x550em_a &&
 	    hw->phy.nw_mng_if_sel & IXGBE_NW_MNG_IF_SEL_MDIO_ACT) {
@@ -3735,7 +3735,7 @@ static int ixgbe_acquire_swfw_sync_x550em_a(struct ixgbe_hw *hw, u32 mask)
  * @hw: pointer to hardware structure
  * @mask: Mask to specify which semaphore to release
  *
- * Release the SWFW semaphore and puts the shared PHY token as needed
+ * Release the SWFW semaphore and puts back the shared PHY token as needed
  */
 static void ixgbe_release_swfw_sync_x550em_a(struct ixgbe_hw *hw, u32 mask)
 {
@@ -3756,7 +3756,7 @@ static void ixgbe_release_swfw_sync_x550em_a(struct ixgbe_hw *hw, u32 mask)
  * @phy_data: Pointer to read data from PHY register
  *
  * Reads a value from a specified PHY register using the SWFW lock and PHY
- * Token. The PHY Token is needed since the MDIO is shared between to MAC
+ * Token. The PHY Token is needed since the MDIO is shared between two MAC
  * instances.
  */
 static int ixgbe_read_phy_reg_x550a(struct ixgbe_hw *hw, u32 reg_addr,
-- 
2.47.1


